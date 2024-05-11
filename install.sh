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
        php.x86_64 \
        flamegraph-stackcollapse-php.noarch \
        kdevelop-php.i686 \
        kdevelop-php.x86_64 \
        mlt-php.x86_64 \
        mod_suphp.x86_64 \
        owfs-php.x86_64 \
        perl-PHP-Serialization.noarch \
        php-Faker.noarch \
        php-LightweightPicasaAPI.noarch \
        php-PHPParser.noarch \
        php-Smarty.noarch \
        php-adodb.noarch \
        php-alcaeus-mongo-php-adapter.noarch \
        php-andrewsville-php-token-reflection.noarch \
        php-aws-sdk3.noarch \
        php-bacon-qr-code2.noarch \
        php-bantu-ini-get-wrapper.noarch \
        php-bcmath.x86_64 \
        php-cli.x86_64 \
        php-common.x86_64 \
        php-cs-fixer.noarch \
        php-dasprid-enum.noarch \
        php-dba.x86_64 \
        php-dbg.x86_64 \
        php-devel.x86_64 \
        php-doctrine-annotations.noarch \
        php-doctrine-event-manager.noarch \
        php-doctrine-instantiator.noarch \
        php-domxml-php4-php5.noarch \
        php-echonest-api.noarch \
        php-email-address-validation.noarch \
        php-embedded.x86_64 \
        php-enchant.x86_64 \
        php-erusev-parsedown.noarch \
        php-facedetect.x86_64 \
        php-fedora-autoloader-devel.noarch \
        php-fgrosse-phpasn1.noarch \
        php-fpm.x86_64 \
        php-gd.x86_64 \
        php-geos.x86_64 \
        php-getid3.noarch \
        php-gettext-gettext.noarch \
        php-giggsey-locale.noarch \
        php-gmp.x86_64 \
        php-google-recaptcha.noarch \
        php-guzzlehttp-guzzle6.noarch \
        php-hamcrest2.noarch \
        php-htmLawed.noarch \
        php-icewind-smb2.noarch \
        php-intl.x86_64 \
        php-jdorn-sql-formatter.noarch \
        php-kissifrot-php-ixr.noarch \
        php-kolabformat.x86_64 \
        php-ldap.x86_64 \
        php-league-plates.noarch \
        php-libguestfs.x86_64 \
        php-libvirt.x86_64 \
        php-libvirt-doc.noarch \
        php-liuggio-statsd-php-client.noarch \
        php-manual-en.noarch \
        php-mapserver.x86_64 \
        php-marcusschwarz-lesserphp.noarch \
        php-markdown.noarch \
        php-mbstring.x86_64 \
        php-microsoft-tolerant-php-parser.noarch \
        php-mikealmond-musicbrainz.noarch \
        php-mikey179-vfsstream.noarch \
        php-mnapoli-phpunit-easymock.noarch \
        php-mock-integration2.noarch \
        php-mock-phpunit2.noarch \
        php-mock2.noarch \
        php-mockery.noarch \
        php-myclabs-php-enum.noarch \
        php-mysqlnd.x86_64 \
        php-netresearch-jsonmapper.noarch \
        php-nikic-php-parser3.noarch \
        php-nikic-php-parser4.noarch \
        php-nikic-php-parser5.noarch \
        php-nyholm-psr7.noarch \
        php-oauth.noarch \
        php-ocramius-code-generator-utils.noarch \
        php-odbc.x86_64 \
        php-opencloud-openstack.noarch \
        php-paragonie-random-compat.noarch \
        php-pdb.noarch \
        php-pdo.x86_64 \
        php-pear.noarch \
        php-pear-CAS.noarch \
        php-pear-Cache-Lite.noarch \
        php-pear-Net-Curl.noarch \
        php-pear-Net-IDNA2.noarch \
        php-pear-PHP-CodeSniffer.noarch \
        php-pear-XML-Parser.noarch \
        php-pear-math-biginteger.noarch \
        php-pecl-ds.x86_64 \
        php-pecl-gearman.x86_64 \
        php-pecl-igbinary.x86_64 \
        php-pecl-mailparse.x86_64 \
        php-pecl-mongodb.x86_64 \
        php-pecl-oauth.x86_64 \
        php-pecl-raphf-devel.x86_64 \
        php-pecl-rrd.x86_64 \
        php-pecl-selinux.x86_64 \
        php-pecl-uuid.x86_64 \
        php-pgsql.x86_64 \
        php-php-gettext.noarch \
        php-phpdocumentor-reflection-common.noarch \
        php-phpdocumentor-reflection-common2.noarch \
        php-phpdocumentor-reflection1.noarch \
        php-phpmailer6.noarch \
        php-phpseclib.noarch \
        php-phpspec-prophecy.noarch \
        php-phpspec-prophecy-phpunit.noarch \
        php-phpunit-Version.noarch \
        php-phpunit-php-code-coverage10.noarch \
        php-phpunit-php-code-coverage6.noarch \
        php-phpunit-php-code-coverage7.noarch \
        php-phpunit-php-code-coverage9.noarch \
        php-phpunit-php-timer2.noarch \
        php-phpunit-php-timer3.noarch \
        php-phpunit-php-timer5.noarch \
        php-phpunit-php-timer6.noarch \
        php-phpunit-php-token-stream3.noarch \
        php-phpunit-php-token-stream4.noarch \
        php-phpunitgoodpractices-polyfill.noarch \
        php-pimple.noarch \
        php-pragmarx-google2fa5.noarch \
        php-process.x86_64 \
        php-pspell.x86_64 \
        php-punic.noarch \
        php-sabre-dav4.noarch \
        php-sanmai-phpunit-legacy-adapter.noarch \
        php-scssphp.noarch \
        php-sebastian-code-unit.noarch \
        php-sebastian-code-unit2.noarch \
        php-sebastian-comparator3.noarch \
        php-sebastian-comparator4.noarch \
        php-sebastian-comparator5.noarch \
        php-sebastian-complexity.noarch \
        php-sebastian-complexity3.noarch \
        php-sebastian-environment4.noarch \
        php-sebastian-environment5.noarch \
        php-sebastian-environment6.noarch \
        php-sebastian-exporter3.noarch \
        php-sebastian-exporter4.noarch \
        php-sebastian-exporter5.noarch \
        php-sebastian-lines-of-code.noarch \
        php-sebastian-lines-of-code2.noarch \
        php-sebastian-recursion-context3.noarch \
        php-sebastian-recursion-context4.noarch \
        php-sebastian-recursion-context5.noarch \
        php-sebastian-recursion-context6.noarch \
        php-sebastian-resource-operations2.noarch \
        php-sebastian-resource-operations3.noarch \
        php-sebastian-type.noarch \
        php-sebastian-type3.noarch \
        php-sebastian-type4.noarch \
        php-sebastian-type5.noarch \
        php-sebastian-version3.noarch \
        php-sebastian-version4.noarch \
        php-sentry.noarch \
        php-simplepie.noarch \
        php-smbclient.x86_64 \
        php-snmp.x86_64 \
        php-soap.x86_64 \
        php-splitbrain-php-archive.noarch \
        php-splitbrain-php-cli.noarch \
        php-splitbrain-php-jsstrip.noarch \
        php-splitbrain-slika.noarch \
        php-swaggest-json-diff.noarch \
        php-swaggest-json-schema.noarch \
        php-swiftmailer6.noarch \
        php-tcpdf.noarch \
        php-tecnickcom-tc-lib-barcode.noarch \
        php-tecnickcom-tc-lib-color.noarch \
        php-theseer-fDOMDocument.noarch \
        php-theseer-tokenizer.noarch \
        php-tidy.x86_64 \
        php-twig.noarch \
        php-wikimedia-assert.noarch \
        php-wikimedia-avro.noarch \
        php-wikimedia-cdb.noarch \
        php-xml.x86_64 \
        php-xmpphp.noarch \
        php-yoast-phpunit-polyfills.noarch \
        php-zetacomponents-console-tools-doc.noarch \
        php-zipstream.noarch \
        php-zordius-lightncandy.noarch \
        php-zstd-devel.x86_64 \
        php-zumba-json-serializer.noarch \
        phpcov.noarch \
        phpcpd.noarch \
        phpunit10.noarch \
        phpunit7.noarch \
        phpunit8.noarch \
        phpunit9.noarch \
        python-calcephpy-doc.noarch \
        python3-phply.noarch \
        python3-phpserialize.noarch \
        python3-sphinxcontrib-phpdomain.noarch \
        sphinx-php.x86_64 \
        uwsgi-plugin-php.x86_64 \
        vim-syntastic-php.noarch \
        php-IDNA_Convert.noarch \
        php-Monolog.noarch \
        php-PsrLog.noarch \
        php-ast.x86_64 \
        php-aws-php-sns-message-validator.noarch \
        php-bartlett-PHP-CompatInfo.noarch \
        php-brick-math.noarch \
        php-brick-varexporter.noarch \
        php-cache-adapter-common.noarch \
        php-cache-filesystem-adapter.noarch \
        php-cache-integration-tests.noarch \
        php-cache-tag-interop.noarch \
        php-composer-ca-bundle.noarch \
        php-composer-metadata-minifier.noarch \
        php-composer-pcre.noarch \
        php-composer-spdx-licenses.noarch \
        php-composer-xdebug-handler.noarch \
        php-composer-xdebug-handler2.noarch \
        php-cssjanus.noarch \
        php-deepdiver-zipstreamer.noarch \
        php-doctrine-cache.noarch \
        php-doctrine-collections.noarch \
        php-doctrine-common.noarch \
        php-doctrine-common3.noarch \
        php-doctrine-datafixtures.noarch \
        php-doctrine-dbal.noarch \
        php-doctrine-deprecations.noarch \
        php-doctrine-doctrine-bundle.noarch \
        php-doctrine-doctrine-cache-bundle.noarch \
        php-doctrine-inflector.noarch \
        php-doctrine-inflector2.noarch \
        php-doctrine-lexer.noarch \
        php-doctrine-orm.noarch \
        php-doctrine-persistence.noarch \
        php-doctrine-persistence2.noarch \
        php-doctrine-persistence3.noarch \
        php-doctrine-reflection.noarch \
        php-doctrine-sql-formatter.noarch \
        php-egulias-email-validator.noarch \
        php-egulias-email-validator2.noarch \
        php-endroid-qrcode.noarch \
        php-fedora-autoloader.noarch \
        php-feedcreator.noarch \
        php-felixfbecker-advanced-json-rpc3.noarch \
        php-ffi.x86_64 \
        php-fig-http-message-util.noarch \
        php-fig-link-util.noarch \
        php-geshi.noarch \
        php-gettext-languages.noarch \
        php-guzzlehttp-promises.noarch \
        php-guzzlehttp-psr7.noarch \
        php-http-interop-http-middleware.noarch \
        php-http-message-factory.noarch \
        php-iamcal-lib-autolink.noarch \
        php-icewind-streams.noarch \
        php-interfasys-lognormalizer.noarch \
        php-ircmaxell-random-lib.noarch \
        php-ircmaxell-security-lib.noarch \
        php-justinrainbow-json-schema5.noarch \
        php-khanamiryan-qrcode-detector-decoder.noarch \
        php-kukulich-fshl.noarch \
        php-league-container4.noarch \
        php-league-flysystem.noarch \
        php-league-mime-type-detection.noarch \
        php-league-tactician.noarch \
        php-league-uri-interfaces.noarch \
        php-masterminds-html5.noarch \
        php-maxmind-db-reader.noarch \
        php-maxminddb.x86_64 \
        php-mongodb.noarch \
        php-mtdowling-jmespath-php.noarch \
        php-myclabs-deep-copy.noarch \
        php-oojs-oojs-ui.noarch \
        php-opcache.x86_64 \
        php-openpsa-universalfeedcreator.noarch \
        php-opis-closure.noarch \
        php-paragonie-constant-time-encoding.noarch \
        php-patchwork-jsqueeze.noarch \
        php-pdo-dblib.x86_64 \
        php-pdo-firebird.x86_64 \
        php-pear-Auth-SASL.noarch \
        php-pear-CodeGen.noarch \
        php-pear-CodeGen-PECL.noarch \
        php-pear-Console-Getargs.noarch \
        php-pear-Console-Table.noarch \
        php-pear-Crypt-Blowfish.noarch \
        php-pear-Crypt-CHAP.noarch \
        php-pear-Date.noarch \
        php-pear-File-Fstab.noarch \
        php-pear-File-Passwd.noarch \
        php-pear-HTML-Template-IT.noarch \
        php-pear-HTTP-Request.noarch \
        php-pear-Image-Text.noarch \
        php-pear-Mail.noarch \
        php-pear-Mail-Mime.noarch \
        php-pear-Mail-mimeDecode.noarch \
        php-pear-Net-IMAP.noarch \
        php-pear-Net-SMTP.noarch \
        php-pear-Net-Sieve.noarch \
        php-pear-Net-Socket.noarch \
        php-pear-Net-URL.noarch \
        php-pear-OLE.noarch \
        php-pear-PEAR-Command-Packaging.noarch \
        php-pear-Text-Figlet.noarch \
        php-pear-XML-SVG.noarch \
        php-pecl-amqp.x86_64 \
        php-pecl-apcu.x86_64 \
        php-pecl-apcu-devel.x86_64 \
        php-pecl-apfd.x86_64 \
        php-pecl-dio.x86_64 \
        php-pecl-event.x86_64 \
        php-pecl-fann.x86_64 \
        php-pecl-geoip.x86_64 \
        php-pecl-http.x86_64 \
        php-pecl-http-devel.x86_64 \
        php-pecl-igbinary-devel.x86_64 \
        php-pecl-imagick.x86_64 \
        php-pecl-imagick-devel.x86_64 \
        php-pecl-inotify.x86_64 \
        php-pecl-ip2location.x86_64 \
        php-pecl-json-post.x86_64 \
        php-pecl-krb5.x86_64 \
        php-pecl-krb5-devel.x86_64 \
        php-pecl-lzf.x86_64 \
        php-pecl-mcrypt.x86_64 \
        php-pecl-memcache.x86_64 \
        php-pecl-memcached.x86_64 \
        php-pecl-msgpack.x86_64 \
        php-pecl-msgpack-devel.x86_64 \
        php-pecl-pcov.x86_64 \
        php-pecl-pq.x86_64 \
        php-pecl-raphf.x86_64 \
        php-pecl-redis5.x86_64 \
        php-pecl-rpminfo.x86_64 \
        php-pecl-ssdeep.x86_64 \
        php-pecl-ssh2.x86_64 \
        php-pecl-uopz.x86_64 \
        php-pecl-var-representation.x86_64 \
        php-pecl-xattr.x86_64 \
        php-pecl-xdebug3.x86_64 \
        php-pecl-xmldiff.x86_64 \
        php-pecl-xmlrpc.x86_64 \
        php-pecl-yac.x86_64 \
        php-pecl-zip.x86_64 \
        php-phar-io-manifest.noarch \
        php-phar-io-manifest2.noarch \
        php-phar-io-version.noarch \
        php-phar-io-version3.noarch \
        php-phpdocumentor-reflection-docblock.noarch \
        php-phpdocumentor-reflection-docblock2.noarch \
        php-phpdocumentor-reflection-docblock4.noarch \
        php-phpdocumentor-reflection-docblock5.noarch \
        php-phpdocumentor-type-resolver.noarch \
        php-phpdocumentor-type-resolver1.noarch \
        php-phpiredis.x86_64 \
        php-phplang-scope-exit.noarch \
        php-phpunit-Text-Template.noarch \
        php-phpunit-git.noarch \
        php-phpunit-php-file-iterator2.noarch \
        php-phpunit-php-file-iterator3.noarch \
        php-phpunit-php-file-iterator4.noarch \
        php-phpunit-php-invoker2.noarch \
        php-phpunit-php-invoker3.noarch \
        php-phpunit-php-invoker4.noarch \
        php-phpunit-php-text-template2.noarch \
        php-phpunit-php-text-template3.noarch \
        php-psr-cache.noarch \
        php-psr-container.noarch \
        php-psr-container2.noarch \
        php-psr-event-dispatcher.noarch \
        php-psr-http-factory.noarch \
        php-psr-http-message.noarch \
        php-psr-http-server-handler.noarch \
        php-psr-http-server-middleware.noarch \
        php-psr-link.noarch \
        php-psr-simple-cache.noarch \
        php-ralouphie-getallheaders.noarch \
        php-ramsey-collection.noarch \
        php-ramsey-uuid.noarch \
        php-sabre-event5.noarch \
        php-sabre-http5.noarch \
        php-sabre-uri2.noarch \
        php-sabre-vobject4.noarch \
        php-sabre-xml2.noarch \
        php-samyoul-u2f-php-server.noarch \
        php-sebastian-cli-parser.noarch \
        php-sebastian-cli-parser2.noarch \
        php-sebastian-code-unit-reverse-lookup.noarch \
        php-sebastian-code-unit-reverse-lookup2.noarch \
        php-sebastian-code-unit-reverse-lookup3.noarch \
        php-sebastian-diff3.noarch \
        php-sebastian-diff4.noarch \
        php-sebastian-diff5.noarch \
        php-sebastian-diff6.noarch \
        php-sebastian-global-state2.noarch \
        php-sebastian-global-state3.noarch \
        php-sebastian-global-state5.noarch \
        php-sebastian-global-state6.noarch \
        php-sebastian-object-enumerator3.noarch \
        php-sebastian-object-enumerator4.noarch \
        php-sebastian-object-enumerator5.noarch \
        php-sebastian-object-reflector.noarch \
        php-sebastian-object-reflector2.noarch \
        php-sebastian-object-reflector3.noarch \
        php-sebastian-object-reflector4.noarch \
        php-seld-cli-prompt.noarch \
        php-seld-phar-utils.noarch \
        php-smarty-gettext.noarch \
        php-sodium.x86_64 \
        php-stecman-symfony-console-completion.noarch \
        php-symfony-asset.noarch \
        php-symfony-browser-kit.noarch \
        php-symfony-class-loader.noarch \
        php-symfony-common.noarch \
        php-symfony-config.noarch \
        php-symfony-console.noarch \
        php-symfony-contracts.noarch \
        php-symfony-contracts2.noarch \
        php-symfony-css-selector.noarch \
        php-symfony-debug.noarch \
        php-symfony-debug-bundle.noarch \
        php-symfony-dependency-injection.noarch \
        php-symfony-doctrine-bridge.noarch \
        php-symfony-dom-crawler.noarch \
        php-symfony-event-dispatcher.noarch \
        php-symfony-expression-language.noarch \
        php-symfony-filesystem.noarch \
        php-symfony-finder.noarch \
        php-symfony-form.noarch \
        php-symfony-framework-bundle.noarch \
        php-symfony-http-foundation.noarch \
        php-symfony-http-kernel.noarch \
        php-symfony-intl.noarch \
        php-symfony-ldap.noarch \
        php-symfony-locale.noarch \
        php-symfony-monolog-bridge.noarch \
        php-symfony-monolog-bundle.noarch \
        php-symfony-options-resolver.noarch \
        php-symfony-process.noarch \
        php-symfony-property-access.noarch \
        php-symfony-property-info.noarch \
        php-symfony-psr-http-message-bridge.noarch \
        php-symfony-requirements-checker.noarch \
        php-symfony-routing.noarch \
        php-symfony-security.noarch \
        php-symfony-security-acl.noarch \
        php-symfony-security-bundle.noarch \
        php-symfony-serializer.noarch \
        php-symfony-stopwatch.noarch \
        php-symfony-templating.noarch \
        php-symfony-translation.noarch \
        php-symfony-twig-bridge.noarch \
        php-symfony-twig-bundle.noarch \
        php-symfony-validator.noarch \
        php-symfony-web-profiler-bundle.noarch \
        php-symfony-yaml.noarch \
        php-symfony4-asset.noarch \
        php-symfony4-browser-kit.noarch \
        php-symfony4-cache.noarch \
        php-symfony4-common.noarch \
        php-symfony4-config.noarch \
        php-symfony4-console.noarch \
        php-symfony4-css-selector.noarch \
        php-symfony4-debug.noarch \
        php-symfony4-debug-bundle.noarch \
        php-symfony4-dependency-injection.noarch \
        php-symfony4-doctrine-bridge.noarch \
        php-symfony4-dom-crawler.noarch \
        php-symfony4-dotenv.noarch \
        php-symfony4-error-handler.noarch \
        php-symfony4-event-dispatcher.noarch \
        php-symfony4-expression-language.noarch \
        php-symfony4-filesystem.noarch \
        php-symfony4-finder.noarch \
        php-symfony4-form.noarch \
        php-symfony4-framework-bundle.noarch \
        php-symfony4-http-client.noarch \
        php-symfony4-http-foundation.noarch \
        php-symfony4-http-kernel.noarch \
        php-symfony4-inflector.noarch \
        php-symfony4-intl.noarch \
        php-symfony4-lock.noarch \
        php-symfony4-mailer.noarch \
        php-symfony4-messenger.noarch \
        php-symfony4-mime.noarch \
        php-symfony4-monolog-bridge.noarch \
        php-symfony4-options-resolver.noarch \
        php-symfony4-process.noarch \
        php-symfony4-property-access.noarch \
        php-symfony4-property-info.noarch \
        php-symfony4-routing.noarch \
        php-symfony4-security.noarch \
        php-symfony4-security-bundle.noarch \
        php-symfony4-serializer.noarch \
        php-symfony4-stopwatch.noarch \
        php-symfony4-templating.noarch \
        php-symfony4-translation.noarch \
        php-symfony4-twig-bridge.noarch \
        php-symfony4-twig-bundle.noarch \
        php-symfony4-validator.noarch \
        php-symfony4-web-link.noarch \
        php-symfony4-web-profiler-bundle.noarch \
        php-symfony4-web-server-bundle.noarch \
        php-symfony4-workflow.noarch \
        php-symfony4-yaml.noarch \
        php-tcpdf-dejavu-lgc-sans-fonts.noarch \
        php-tcpdf-dejavu-lgc-sans-mono-fonts.noarch \
        php-tcpdf-dejavu-lgc-serif-fonts.noarch \
        php-tcpdf-dejavu-sans-fonts.noarch \
        php-tcpdf-dejavu-sans-mono-fonts.noarch \
        php-tcpdf-dejavu-serif-fonts.noarch \
        php-tcpdf-gnu-free-mono-fonts.noarch \
        php-tcpdf-gnu-free-sans-fonts.noarch \
        php-tcpdf-gnu-free-serif-fonts.noarch \
        php-theseer-autoload.noarch \
        php-theseer-directoryscanner.noarch \
        php-true-punycode.noarch \
        php-webimpress-http-middleware-compatibility.noarch \
        php-webimpress-safe-writer.noarch \
        php-webmozart-assert.noarch \
        php-wikimedia-ip-set.noarch \
        php-wikimedia-utfnormal.noarch \
        php-williamdes-mariadb-mysql-kbs.noarch \
        php-zetacomponents-base.noarch \
        php-zetacomponents-console-tools.noarch \
        php-zetacomponents-unit-test.noarch \
        php-zmq.x86_64 \
        php-zstd.x86_64 \
        phpMyAdmin.noarch \
        phpldapadmin.noarch \
        python3-calcephpy.x86_64 \
        texlive-graphpaper.noarch \
        composer.noarch \
        lighttpd-fastcgi.x86_64
	
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
