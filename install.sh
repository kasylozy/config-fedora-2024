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
        xfce4-settings \
        neofetch \
        polybar \
        dkms \
        arc-theme \
        gnome-screenshot \
        gnome-disk-utility \
        nautilus \
        i3{,-gaps,status,blocks,lock} \
        fontawesome4-fonts
}

function installPhp () {
        sudo dnf install https://rpms.remirepo.net/fedora/remi-release-39.rpm -y
        sudo dnf config-manager --set-enabled remi -y
        sudo dnf module switch-to php:remi-8.3 -y
        sudo dnf module install php:remi-8.3 -y
        sudo dnf install -y \
        php83.x86_64 \
        php83-php-pecl-handlebars-devel.x86_64 \
        php83-php-pecl-pcsc-devel.x86_64 \
        php83-php-pecl-psr-devel.x86_64 \
        php83-php-pecl-raphf-devel.x86_64 \
        php83-php-pecl-simdjson-devel.x86_64 \
        php83-php-pecl-xmldiff-devel.x86_64 \
        php83-php-pecl-yaconf-devel.x86_64 \
        php83-php-zephir-parser-devel.x86_64 \
        php83-php-zstd-devel.x86_64 \
        php83-runtime.x86_64 \
        php83-scldevel.x86_64 \
        php83-build.x86_64 \
        php83-php.x86_64 \
        php83-php-ast.x86_64 \
        php83-php-bcmath.x86_64 \
        php83-php-bolt.x86_64 \
        php83-php-brotli.x86_64 \
        php83-php-cli.x86_64 \
        php83-php-common.x86_64 \
        php83-php-dba.x86_64 \
        php83-php-dbg.x86_64 \
        php83-php-devel.x86_64 \
        php83-php-embedded.x86_64 \
        php83-php-enchant.x86_64 \
        php83-php-ffi.x86_64 \
        php83-php-fpm.x86_64 \
        php83-php-gd.x86_64 \
        php83-php-geos.x86_64 \
        php83-php-gmp.x86_64 \
        php83-php-imap.x86_64 \
        php83-php-intl.x86_64 \
        php83-php-ldap.x86_64 \
        php83-php-libvirt.x86_64 \
        php83-php-libvirt-doc.noarch \
        php83-php-litespeed.x86_64 \
        php83-php-lz4.x86_64 \
        php83-php-maxminddb.x86_64 \
        php83-php-mbstring.x86_64 \
        php83-php-mysqlnd.x86_64 \
        php83-php-odbc.x86_64 \
        php83-php-pdlib.x86_64 \
        php83-php-pdo.x86_64 \
        php83-php-pdo-dblib.x86_64 \
        php83-php-pdo-firebird.x86_64 \
        php83-php-pear.noarch \
        php83-php-pecl-ahocorasick.x86_64 \
        php83-php-pecl-amqp.x86_64 \
        php83-php-pecl-apcu.x86_64 \
        php83-php-pecl-apcu-devel.x86_64 \
        php83-php-pecl-apfd.x86_64 \
        php83-php-pecl-awscrt.x86_64 \
        php83-php-pecl-base58.x86_64 \
        php83-php-pecl-bitset.x86_64 \
        php83-php-pecl-bsdiff.x86_64 \
        php83-php-pecl-cassandra.x86_64 \
        php83-php-pecl-crypto.x86_64 \
        php83-php-pecl-csv.x86_64 \
        php83-php-pecl-datadog-trace.x86_64 \
        php83-php-pecl-dbase.x86_64 \
        php83-php-pecl-decimal.x86_64 \
        php83-php-pecl-dio.x86_64 \
        php83-php-pecl-ds.x86_64 \
        php83-php-pecl-ecma-intl.x86_64 \
        php83-php-pecl-eio.x86_64 \
        php83-php-pecl-env.x86_64 \
        php83-php-pecl-ev.x86_64 \
        php83-php-pecl-event.x86_64 \
        php83-php-pecl-excimer.x86_64 \
        php83-php-pecl-fann.x86_64 \
        php83-php-pecl-gearman.x86_64 \
        php83-php-pecl-geoip.x86_64 \
        php83-php-pecl-geospatial.x86_64 \
        php83-php-pecl-gmagick.x86_64 \
        php83-php-pecl-gnupg.x86_64 \
        php83-php-pecl-grpc.x86_64 \
        php83-php-pecl-handlebars.x86_64 \
        php83-php-pecl-hdr-histogram.x86_64 \
        php83-php-pecl-http.x86_64 \
        php83-php-pecl-http-devel.x86_64 \
        php83-php-pecl-igbinary.x86_64 \
        php83-php-pecl-igbinary-devel.x86_64 \
        php83-php-pecl-immutable-cache.x86_64 \
        php83-php-pecl-immutable-cache-devel.x86_64 \
        php83-php-pecl-inotify.x86_64 \
        php83-php-pecl-ion.x86_64 \
        php83-php-pecl-ip2location.x86_64 \
        php83-php-pecl-ip2proxy.x86_64 \
        php83-php-pecl-json-post.x86_64 \
        php83-php-pecl-jsonpath.x86_64 \
        php83-php-pecl-krb5.x86_64 \
        php83-php-pecl-krb5-devel.x86_64 \
        php83-php-pecl-leveldb.x86_64 \
        php83-php-pecl-luasandbox.x86_64 \
        php83-php-pecl-lzf.x86_64 \
        php83-php-pecl-mailparse.x86_64 \
        php83-php-pecl-mcrypt.x86_64 \
        php83-php-pecl-memcache.x86_64 \
        php83-php-pecl-memcached.x86_64 \
        php83-php-pecl-memprof.x86_64 \
        php83-php-pecl-mongodb.x86_64 \
        php83-php-pecl-msgpack.x86_64 \
        php83-php-pecl-msgpack-devel.x86_64 \
        php83-php-pecl-mustache.x86_64 \
        php83-php-pecl-mysql.x86_64 \
        php83-php-pecl-mysqlnd-krb.x86_64 \
        php83-php-pecl-nsq.x86_64 \
        php83-php-pecl-oauth.x86_64 \
        php83-php-pecl-opencensus.x86_64 \
        php83-php-pecl-opentelemetry.x86_64 \
        php83-php-pecl-pam.x86_64 \
        php83-php-pecl-parle.x86_64 \
        php83-php-pecl-pcov.x86_64 \
        php83-php-pecl-pcsc.x86_64 \
        php83-php-pecl-pkcs11.x86_64 \
        php83-php-pecl-pq.x86_64 \
        php83-php-pecl-protobuf.x86_64 \
        php83-php-pecl-ps.x86_64 \
        php83-php-pecl-psr.x86_64 \
        php83-php-pecl-quickhash.x86_64 \
        php83-php-pecl-raphf.x86_64 \
        php83-php-pecl-rar.x86_64 \
        php83-php-pecl-rdkafka6.x86_64 \
        php83-php-pecl-recode.x86_64 \
        php83-php-pecl-rnp.x86_64 \
        php83-php-pecl-rpminfo.x86_64 \
        php83-php-pecl-rrd.x86_64 \
        php83-php-pecl-scoutapm.x86_64 \
        php83-php-pecl-scrypt.x86_64 \
        php83-php-pecl-sdl.x86_64 \
        php83-php-pecl-sdl-image.x86_64 \
        php83-php-pecl-sdl-mixer.x86_64 \
        php83-php-pecl-sdl-ttf.x86_64 \
        php83-php-pecl-seasclick.x86_64 \
        php83-php-pecl-seaslog.x86_64 \
        php83-php-pecl-seassnowflake.x86_64 \
        php83-php-pecl-selinux.x86_64 \
        php83-php-pecl-simdjson.x86_64 \
        php83-php-pecl-simple-kafka-client.x86_64 \
        php83-php-pecl-skywalking.x86_64 \
        php83-php-pecl-skywalking-agent.x86_64 \
        php83-php-pecl-solr2.x86_64 \
        php83-php-pecl-ssdeep.x86_64 \
        php83-php-pecl-ssh2.x86_64 \
        php83-php-pecl-stats.x86_64 \
        php83-php-pecl-stomp.x86_64 \
        php83-php-pecl-sync.x86_64 \
        php83-php-pecl-teds.x86_64 \
        php83-php-pecl-trader.x86_64 \
        php83-php-pecl-translit.x86_64 \
        php83-php-pecl-trie.x86_64 \
        php83-php-pecl-uopz.x86_64 \
        php83-php-pecl-uploadprogress.x86_64 \
        php83-php-pecl-uuid.x86_64 \
        php83-php-pecl-uv.x86_64 \
        php83-php-pecl-var-representation.x86_64 \
        php83-php-pecl-varnish.x86_64 \
        php83-php-pecl-vips.x86_64 \
        php83-php-pecl-vld.x86_64 \
        php83-php-pecl-xattr.x86_64 \
        php83-php-pecl-xdebug3.x86_64 \
        php83-php-pecl-xdiff.x86_64 \
        php83-php-pecl-xhprof.x86_64 \
        php83-php-pecl-xlswriter.x86_64 \
        php83-php-pecl-xmldiff.x86_64 \
        php83-php-pecl-xmlrpc.x86_64 \
        php83-php-pecl-xxtea.x86_64 \
        php83-php-pecl-yac.x86_64 \
        php83-php-pecl-yaconf.x86_64 \
        php83-php-pecl-yaf.x86_64 \
        php83-php-pecl-yaml.x86_64 \
        php83-php-pecl-yar.x86_64 \
        php83-php-pecl-yaz.x86_64 \
        php83-php-pecl-zip.x86_64 \
        php83-php-pecl-zmq.x86_64 \
        php83-php-pgsql.x86_64 \
        php83-php-phalcon5.x86_64 \
        php83-php-process.x86_64 \
        php83-php-pspell.x86_64 \
        php83-php-realpath-turbo.x86_64 \
        php83-php-smbclient.x86_64 \
        php83-php-snappy.x86_64 \
        php83-php-snmp.x86_64 \
        php83-php-snuffleupagus.x86_64 \
        php83-php-soap.x86_64 \
        php83-php-sodium.x86_64 \
        php83-php-tidy.x86_64 \
        php83-php-xml.x86_64 \
        php83-php-xz.x86_64 \
        php83-php-zephir-parser.x86_64 \
        php83-php-zstd.x86_64 \
        php83-unit-php.x86_64 \
        php83-uwsgi-plugin-php.x86_64 \
        php83-xhprof.noarch \
        php-pdo \
        php-mysql \
        composer
}

function installMariadb () {
      sudo dnf install mariadb-server -y
      if [ `systemctl is-enabled mariadb` = "disabled" ]; then
              sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
              sudo systemctl enable --now mariadb
              sudo mysql -uroot -proot -e "create user root@'%' identified by 'root';"
              sudo mysql -uroot -proot -e "grant all privileges on *.* to root@'%';"
              sudo mysql -uroot -proot -e "grant all privileges on *.* to root@'%';"
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

function move_default_picture() {
	    rsync -avPh ./Pictures ~/Images
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
  installPhp
  installMariadb
  installFlatpack
  configure_ohMyZsh
  configure_postfix
  maildev_docker
  configure
}

main

echo ""
echo ""
echo "Redémarrer l'ordinateur pour terminer la configuration !"
exit 0
