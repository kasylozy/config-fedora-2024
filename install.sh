#!/bin/bash

set -e

function installPackages () {
        sudo dnf install -y \
        git \
        firefox \
        rsync \
        wget \
        vim \
        alacritty \
        pwgen \
        htop \
        chromium \
        polkit-gnome \
        ntfs-3g \
        vlc \
        gnome-system-monitor \
        udisks2 \
        remmina \
        freerdp \
        zip \
        unzip \
        postfix \
        nodejs-npm \
        nodejs \
        ruby \
        zsh \
        picom \
        feh \
        rofi \
        lxappearance \
        thunar \
        thunar-volman \
	thunar-archive-plugin \
 	file-roller \
        xfce4-settings \
        neofetch \
        polybar \
        dkms \
        arc-theme \
        gnome-screenshot \
        gnome-disk-utility \
        nautilus \
        i3{,-gaps,status,blocks,lock} \
        fontawesome4-fonts \
	wine \
	thunderbird
}

function installMariadb () {
      sudo dnf install mariadb-server -y
      if [ `systemctl is-enabled mariadb` = "disabled" ]; then
              sudo systemctl enable --now mariadb
      fi
}

function installFlatpack () {
        flatpak install -y \
        com.opera.Opera \
        com.discordapp.Discord \
        com.spotify.Client
}

function configure_ohMyZsh() {
        if [ ! -d ~/.oh-my-zsh ]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" <<EOF
        exit
EOF
        chsh -s $(which zsh)
        sudo dnf install -y keychain
        mkdir -p -m 700 ~/.ssh
        git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
        sed -i "s/ZSH_THEME=\"robbyrussell\"/#ZSH_THEME=\"robbyrussell\"/" ~/.zshrc
        cat >> ~/.zshrc <<EOF
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
zmodload zsh/nearcolor
zstyle :prompt:pure:path color '#FFFFFF'
zstyle ':prompt:pure:prompt:*' color cyan
zstyle :prompt:pure:git:stash show yes
eval \$(keychain --eval --agents ssh --quick --quiet)
export TERM=xterm-256color
EOF
        fi
}

function configure_postfix() {
        if [ `systemctl is-enabled postfix` = "disabled" ]; then
                postfix_file=/etc/postfix/main.cf
                sudo chmod o+w $postfix_file
                sudo sed -i 's/#relayhost = \[an\.ip\.add\.ress\]/relayhost = 127\.0\.0\.1:1025/' $postfix_file
                sudo chmod o-w $postfix_file
                sudo systemctl enable --now postfix
        fi
}

function maildev_docker() {
        if [ ! -f /usr/bin/docker ]; then
                sudo dnf install docker{,-compose} -y
                if [ `systemctl is-enabled docker.service` = "disabled" ] ; then
                        sudo systemctl enable --now docker.service
                fi
                if ! sudo docker ps | grep mail; then
                        sudo docker run -d --restart unless-stopped -p 1080:1080 -p 1025:1025 dominikserafin/maildev:latest
                fi
        fi
}

function install_php () {
	sudo dnf install -y \
		php \
		php-Faker \
		php-bcmath \
		php-cli \
		php-common \
		php-dba \
		php-dbg \
		php-devel \
		php-enchant \
		php-gd \
		php-geos \
		php-gmp \
		php-intl \
		php-ldap \
		php-markdown \
		php-mbstring \
		php-mysqlnd \
		php-odbc \
		php-pdo \
		php-php-gettext \
		php-snmp \
		php-tidy \
		php-twig \
		php-ffi \
		php-mongodb \
		php-opcache \
		php-sodium \
		php-zmq \
		php-zstd \
		php-pecl-xdebug \
		composer
}

function move_default_picture() {
	    rsync -avPh ./Pictures/ ~/Images/
}

function update_config() {
	    rsync -avPh ./config/* ~/.config/
}

function configure() {
      move_default_picture
      update_config
}

function main () {
  installPackages
  installMariadb
  installFlatpack
  configure_ohMyZsh
  configure_postfix
  maildev_docker
  install_php
  configure
}

main

echo ""
echo ""
echo "Redémarrer l'ordinateur pour terminer la configuration !"
exit 0
