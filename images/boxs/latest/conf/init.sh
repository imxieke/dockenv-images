#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2022-07-01 12:36:33
 # @LastEditTime: 2022-07-11 19:24:20
 # @LastEditors: Cloudflying
 # @Description: Init Docker Images
 # @FilePath: /dockenv/images/boxs/latest/conf/init.sh
###
[ -f '/tmp/conf/entrypoint.sh' ] && cp /tmp/conf/entrypoint.sh /usr/bin/entrypoint && chmod +x /usr/bin/entrypoint

# short package install command
pkg_add()
{
    apt-get install -y --no-install-recommends --no-install-suggests $@
}

# 下载二进制文件 并赋予执行权限
# @param $1 Save Name Or Platform
# @param $2 Platform is exist
# Common Executable Binary,example shell php python
# ~/.bin/all
# Linux
# ~/.bin/lin
# macOS
# ~/.bin/mac
add_bin()
{
    BIN_DIR=${HOME}/.bin
    if [[ "${1}" != 'lin' ]]; then
        SAVE_PATH="${BIN_DIR}/lin/$2"
    elif [[ "${1}" != 'mac' ]]; then
        SAVE_PATH=="${BIN_DIR}/mac/$2"
    else
        SAVE_PATH="${BIN_DIR}/$2"
    fi
    wget -c $1 -O $SAVE_PATH
    chmod +x ${SAVE_PATH}
}

# 添加 VSCode 扩展到 Code Server
# 如 微软开发的 Remote 系列则只允许在 VSC 运行
# usage: vsc_ext_add id
vsc_ext_add()
{
    EXT_DIR=${HOME}/.code-server/exts
    mkdir -p /tmp/vsc-ext
    EXT_ID=$(echo "$1" | tr '[A-Z]' '[a-z]')
    EXT_URL="https://marketplace.visualstudio.com/items?itemName=${EXT_ID}"
    EXT_FILE_URL=$(curl -sL ${EXT_URL} | grep -Eo 'https://\S+gallerycdn.vsassets.io/extensions\S+Default' | head -n 1 | sed 's#Icons.Default#VSIXPackage#g')
    EXT_AUTHOR=$(echo "$EXT_FILE_URL" | awk -F 'extensions/' '{print $2}' | awk -F '/' '{print $1}')
    EXT_NAME=$(echo "$EXT_FILE_URL" | awk -F 'extensions/' '{print $2}' | awk -F '/' '{print $2}')
    EXT_VER=$(echo "$EXT_FILE_URL" | awk -F 'extensions/' '{print $2}' | awk -F '/' '{print $3}')
    FULL_NAME="${EXT_AUTHOR}.${EXT_NAME}-${EXT_VER}"
    wget -c ${EXT_FILE_URL} -O /tmp/vsc-ext/${FULL_NAME}.vsix
    unzip -qo /tmp/vsc-ext/${FULL_NAME}.vsix -d /tmp/vsc-ext/
    mv /tmp/vsc-ext/extension ${EXT_DIR}/${FULL_NAME}
}

apt update -y
apt upgrade -y

# Install Packages
pkg_add ca-certificates locales openssh-server sudo zsh git jq procps htop less file wget curl iputils-ping net-tools \
    neovim supervisor python3-pip

pkg_add 7zip brotli bzip2 gzip lunzip lzip unar unrar unzip p7zip p7zip-full p7zip-rar rar unrar-free zip zstd

# PHP And Composer
pkg_add php8.1-amqp php8.1-ast php8.1-bz2 php8.1-dba php8.1-dev php8.1-ds php8.1-fpm php8.1-gd php8.1-gearman php8.1-gmp php8.1-gnupg php8.1-http php8.1-igbinary php8.1-imap php8.1-interbase php8.1-intl php8.1-ldap php8.1-mailparse php8.1-mbstring php8.1-mongodb php8.1-mysql php8.1-oauth php8.1-pgsql php8.1-phpdbg php8.1-ps php8.1-pspell php8.1-psr php8.1-raphf php8.1-readline php8.1-redis php8.1-rrd php8.1-snmp php8.1-soap php8.1-sqlite3 php8.1-ssh2 php8.1-sybase php8.1-tidy php8.1-uopz php8.1-uploadprogress php8.1-uuid php8.1-xdebug php8.1-xml php8.1-xsl php8.1-yaml php8.1-zip php8.1-zmq php8.1-apcu php8.1-bcmath php8.1-curl php8.1-enchant  php8.1-imagick php8.1-memcache php8.1-memcached php8.1-msgpack php8.1-odbc php8.1-pcov php8.1-xmlrpc php8.1-smbclient
wget -qc https://getcomposer.org/download/latest-stable/composer.phar -O /usr/bin/composer
chmod +x /usr/bin/composer

# for neovim
pip install -U setuptools
pip install pynvim websockets pip_search "python-lsp-server[all]"

# Node
pkg_add nodejs npm
# npm i -g webpack yarn eslint @unibeautify/cli typescript
# npm i -g typescript-language-server vim-language-server

# Config Language And timezone
sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen
sed -i "s/# zh_CN.UTF-8/zh_CN.UTF-8/" /etc/locale.gen
# locale-gen
echo 'Asia/Shanghai' > /etc/timezone
rm -fr /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Config User
useradd -d /home/${RUN_USER} -m -s /bin/zsh ${RUN_USER}
echo "${RUN_USER}:${USER_PASSWD}" | chpasswd
echo "root:${USER_PASSWD}" | chpasswd
# Config sudo SuperPower
echo "${RUN_USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# Config ohmyzsh
git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git ${HOME_DIR}/.oh-my-zsh
cp ${HOME_DIR}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME_DIR}/.zshrc
sed -i 's/ZSH_THEME.*/ZSH_THEME="strug"/g' ${HOME_DIR}/.zshrc

# Config SSH
ssh-keygen -A
sed -i 's/^#ClientAliveInterval.*/ClientAliveInterval 60/g' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/^#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config

# Link vim symbol
ln -sf /usr/bin/nvim /bin/e
ln -sf /usr/bin/nvim /bin/vi
ln -sf /usr/bin/nvim /bin/vim

[ ! -d '/run/sshd' ] && mkdir -p /run/sshd
[ ! -d '/etc/supervisor/conf.d' ] && mkdir -p /etc/supervisor/conf.d
[ -f '/tmp/conf/services.conf' ] && cp /tmp/conf/services.conf /etc/supervisor/conf.d/services.conf

# install extension for code-server
ext_add()
{
    code-server --extensions-dir /home/boxs/.code-server/exts --install-extension $@
}

# Config code-server
if [[ -z "$(command -v code-server)" ]]; then
    CODE_SERVER_LATEST_VER=$(curl -sI https://github.com/coder/code-server/releases/latest | grep '/releases/tag' | grep -Eo '/v\S+.[0-9]' | sed 's#/v##g')
    # sudo systemctl enable --now code-server@$USER
    CODE_SERVER_URL="https://github.com/coder/code-server/releases/download/v${CODE_SERVER_LATEST_VER}/code-server_${CODE_SERVER_LATEST_VER}_amd64.deb"
    wget -c ${CODE_SERVER_URL} -O /tmp/code-server_${CODE_SERVER_LATEST_VER}_amd64.deb
    dpkg -i /tmp/code-server_${CODE_SERVER_LATEST_VER}_amd64.deb

    mkdir -p ${HOME_DIR}/.code-server/exts
    mkdir -p ${HOME_DIR}/.code-server/User
    mkdir -p ${HOME_DIR}/.config/code-server

cat > ${HOME_DIR}/.config/code-server/config.yaml <<EOF
bind-addr: 0.0.0.0:8818
auth: password
password: ideboxs
cert: false
user-data-dir: .code-server
extensions-dir: .code-server/exts
EOF

cat > ${HOME_DIR}/.code-server/User/settings.json << EOF
{
    "workbench.colorTheme": "Solarized Light",
    "sublimeTextKeymap.promptV3Features": true,
    "editor.multiCursorModifier": "ctrlCmd",
    "editor.snippetSuggestions": "top",
    "editor.formatOnPaste": true,
    "workbench.iconTheme": "vscode-icons",
    "window.menuBarVisibility": "classic",
    "database-client.highlightSQLBlock": true,
    "database-client.showUser": true,
    "database-client.showTrigger": true,
    "database-client.showQuery": true,
    "database-client.showFilter": true,
    "database-client.escapedAllObjectName": true,
    "tabnine.experimentalAutoImports": true,
    "tabnine.receiveBetaChannelUpdates": true,
    "editor.fontSize": 16,
    "extensions.autoUpdate": "onlyEnabledExtensions"
}
EOF
    # Add Code Server Extensions
    # 有些插件仅支持运行在 VSCode 如 remote ssh
    # defined to run only in code-server for the Desktop
    # Utils
    ext_add vscode-icons-team.vscode-icons
    ext_add ms-vscode.sublime-keybindings
    ext_add editorconfig.editorconfig
    ext_add eamodio.gitlens
    ext_add esbenp.prettier-vscode
    ext_add cweijan.vscode-ssh
    ext_add dbaeumer.vscode-eslint
    ext_add rangav.vscode-thunder-client

    # Autocomplete
    ext_add tabnine.tabnine-vscode
    ext_add codiga.vscode-plugin

    # Database
    ext_add cweijan.vscode-mysql-client2

    # PHP
    ext_add zobo.php-intellisense
    ext_add bmewburn.vscode-intelephense-client
    ext_add neilbrayfield.php-docblocker
    # A static analysis tool for finding errors in PHP applications
    ext_add getpsalm.psalm-vscode-plugin

    # Language support
    ext_add xadillax.viml
    ext_add octref.vetur # Vue
    # ext_add redhat.vscode-yaml
    # 不兼容 Code Server
    # ext_add ms-ceintl.vscode-language-pack-zh-hans

    # SanderRonde.phpstan-vscode
    # swordev.phpstan

    mkdir -p ${HOME_DIR}/.config/TabNine
    cp -fr /tmp/conf/tabnine_config.json ${HOME_DIR}/.config/TabNine/tabnine_config.json
fi

echo "==> Final Initialize environment"
PHP_VER=8.1
sed -i "s/error_reporting = .*/error_reporting = E_ALL/"                /etc/php/${PHP_VER}/*/php.ini
sed -i "s/display_errors = .*/display_errors = On/"                     /etc/php/${PHP_VER}/*/php.ini
sed -i "s/memory_limit = .*/memory_limit = 256M/"                       /etc/php/${PHP_VER}/*/php.ini
sed -i "s/date.timezone.*/date.timezone = 'Asia\/Shanghai'/"            /etc/php/${PHP_VER}/*/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 512M/"         /etc/php/${PHP_VER}/*/php.ini
sed -i "s/post_max_size = .*/post_max_size = 512M/"                     /etc/php/${PHP_VER}/*/php.ini
sed -i "s/max_file_uploads =.*/max_file_uploads = 256/g"                /etc/php/${PHP_VER}/*/php.ini
sed -i "s/display_startup_errors =.*/display_startup_errors = On/g"     /etc/php/${PHP_VER}/*/php.ini
sed -i "s/log_errors =.*/log_errors = On/g"                             /etc/php/${PHP_VER}/*/php.ini
sed -i "s/default_charset =.*/default_charset = "UTF-8"/g"              /etc/php/${PHP_VER}/*/php.ini
sed -i "s/max_execution_time =.*/max_execution_time = 300/g"            /etc/php/${PHP_VER}/*/php.ini
sed -i "s#^pm.max_children.*#pm.max_children = 32#"                     /etc/php/${PHP_VER}/fpm/php-fpm.conf

# Fetch Binary
add_bin https://github.com/phpstan/phpstan/releases/download/1.8.0/phpstan.phar phpstan
add_bin https://phpmd.org/static/latest/phpmd.phar phpmd
add_bin https://phar.phpunit.de/phpcpd.phar phpcpd
add_bin https://phar.io/releases/phive.phar phive
add_bin https://github.com/phpro/grumphp/releases/download/v1.13.0/grumphp.phar grumphp
add_bin https://github.com/deployphp/deployer/releases/download/v7.0.0-rc.8/deployer.phar deployer
add_bin https://phar.phpunit.de/phpunit.phar phpunit
add_bin https://phar.phpbu.de/phpbu.phar phpbu
add_bin https://github.com/vimeo/psalm/releases/download/4.24.0/psalm.phar psalm
add_bin https://www.phing.info/get/phing-latest.phar phing
add_bin https://github.com/theseer/phpdox/releases/download/0.12.0/phpdox-0.12.0.phar phpdox
add_bin https://github.com/phan/phan/releases/download/5.3.2/phan.phar phan
add_bin https://phpdoc.org/phpDocumentor.phar phpDocumentor
add_bin https://doctum.long-term.support/releases/dev/doctum.phar doctum
add_bin https://github.com/mihaeu/dephpend/releases/download/0.8.0/dephpend-0.8.0.phar dephpend
add_bin https://cs.symfony.com/download/php-cs-fixer-v3.phar hp-cs-fixer
add_bin https://phar.phpunit.de/phploc.phar phploc
add_bin https://github.com/infection/infection/releases/download/0.26.13/infection.phar infection
add_bin https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.7.1/phpcbf.phar phpcbf
add_bin https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.7.1/phpcs.phar phpcs
add_bin https://github.com/qossmic/deptrac/releases/download/0.23.0/deptrac.phar deptrac
add_bin https://www.laravel-enlightn.com/security-checker.phar security-checker

echo "==> Fix User Permission"
chown -R ${RUN_USER}:${RUN_USER} ${HOME_DIR}
chmod -R 755 ${HOME_DIR}
sudo -u ${RUN_USER} mkdir -p ${HOME_DIR}/.config/composer
sudo -u ${RUN_USER} composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
sudo -u ${RUN_USER} composer global --no-plugins --no-scripts require phpstan/phpstan
sudo -u ${RUN_USER} composer global --no-plugins --no-scripts require vimeo/psalm
sudo -u ${RUN_USER} composer global --no-plugins --no-scripts require phpunit/phpunit
sudo -u ${RUN_USER} composer global --no-plugins --no-scripts require phan/phan

echo "==> Clean Container"
rm -fr /root/.npm
rm -fr /root/.wget-hsts
rm -fr /root/.config
rm -fr /root/.local

apt autoremove -y
apt-get clean -y
apt-get autoclean -y
rm -fr /var/lib/apt/lists/*
