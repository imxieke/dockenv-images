FROM ghcr.io/dockenv/debian:sid
LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv

ENV DEBIAN_FRONTEND=noninteractive


RUN echo "deb http://repo.huaweicloud.com/debian sid main" > /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/debian sid contrib" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/debian sid non-free" >> /etc/apt/sources.list \
    && apt update -y \
    && apt upgrade -y \
    && apt install -y xfce4 xfce4-terminal xfce4-whiskermenu-plugin xfce4-datetime-plugin xfce4-goodies \
        xfce4-panel-profiles xfce4-screenshooter xfce4-systemload-plugin xfce4-taskmanager \
    # System
# for compile
# apt_add build-essential
    && apt install -y systemd init lsb-release apt-transport-https apt-utils software-properties-common \
    && apt install -y --no-install-recommends locales supervisor sudo openssh-server \
    && apt install -y --no-install-recommends python3 python3-pip python3-apt iso-codes openssl  gnupg lsof \
        universal-ctags strace psmisc file psutils dnsutils expect \
    && apt install -y --no-install-recommends bat zsh git wget curl httpie axel neovim jq tree screen less iftop enca \
    # Archive Compress
    && apt install -y --no-install-recommends 7zip brotli bzip2 lunzip lzip rpm rar unalz unar unrar unzip unrar-free zip zstd gzip \
        p7zip p7zip-full p7zip-rar \
    # cabextract xz-utils \
    && apt install -y --no-install-recommends net-tools procps htop netcat-openbsd rsync iproute2 whois \
    # Python Plguins
    && apt install -y --no-install-recommends python3-software-properties python3-neovim \
    && apt install -y --no-install-recommends xinit xauth pkg-config yelp yelp-xsl zenity \
    # dialog Displays user-friendly dialog boxes from shell scripts
    && apt install -y --no-install-recommends pavucontrol apulse dialog xvfb alsamixergui alsa-utils alsa-oss alsa-tools alsa-tools-gui \
    # 测试是否可以删除 libgl1-mesa-dri  libnss-wrapper mesa-utils
    # xserver-xorg-video-fbdev xserver-xorg-video-vesa xserver-xorg-input-evdev
    && apt install -y tigervnc-standalone-server xrdp xorgxrdp x11vnc dbus dbus-x11  xdg-utils openbox openbox-menu \
    # && apt install -y --no-install-recommends fonts-ubuntu fonts-noto-mono ttf-ubuntu-font-family ttf-wqy-zenhei xfonts-base xfonts-100dpi \
    # xfonts-75dpi xfonts-scalable xfonts-cyrillic ttf-wqy-zenhei fonts-wqy-zenhei fonts-wqy-microhei xfonts-wqy fonts-mononoki \
    # fonts-noto-mono fonts-liberation \
    && pip install websockify \
    # editor 考虑 sublime text 为替代品
    # && apt install -y --no-install-recommends gedit \
    # 暂时不考虑使用
    # for system service 17 MB
    # && apt install -y --no-install-recommends gvfs gvfs-backends gvfs-bin gvfs-fuse \
    # 139 MB
    # && apt install -y --no-install-recommends fuse3 fuse-overlayfs fuse2fs fusecram fusefat fuseiso fusesmb \
    # 美化
    # mcdu ncurses disk usage viewer
    # catfish 文件搜索神器
    # bleachbit 清理系统垃圾文件
    # meld 视觉差异和合并工具。MELD帮助您比较文件、目录和版本控制的项目
    # synapse 启动器 类似 alfred 的简陋版本
    # fzf 命令行文件快速搜索
    # thunderbird Mail Client
    # && apt install -y --no-install-recommends menulibre ncdu catfish bleachbit meld synapse fzf thunderbird \
    # Remote Desktop
    # && apt install --no-install-recommends -y remmina remmina-plugin-rdp remmina-plugin-vnc remmina-plugin-secret \
    # remmina-plugin-exec remmina-plugin-kwallet remmina-plugin-nx remmina-plugin-spice remmina-plugin-www remmina-plugin-xdmcp

    # multimedia Pic Viewer
    # inkscape vector-based drawing program
    # apt install -y --no-install-recommends nomacs smplayer inkscape \
    # Twin panel file management for your desktop
    # kdiff3 kcompare arj unarj
    # && apt install -y --no-install-recommends krusader krename  \
    # && apt install -y --no-install-recommends language-pack-zh-hans \
    # Other Packages
    # && apt install -y --no-install-recommends sshfs proxychains4 tcpdump \
    # Downloader
    # && apt install -y --no-install-recommends aria2 rtorrent qbittorrent deluge deluged deluge-console deluge-web \
    # && apt install -y --no-install-recommends tmux ffmpeg \
    # midori 轻量级浏览器
    # && apt install -y --no-install-recommends midori firefox firefox-locale-zh-hans \
    # Security
    # clamtk GUI 不好用
    # gufw ufw GUI
    # && apt install --no-install-recommends -y clamav clamtk ufw gufw \
    # Okular universal document viewer 文档阅读软件，支持 PDF、TIFF、CHM、ODF、EPUB、mobi 等文档格式
    # && apt install --no-install-recommends -y okular \
    # Office
    # libreoffice
    # && apt install --no-install-recommends -y libreoffice libreoffice-help-zh-cn libreoffice-l10n-zh-cn \
    # File Manager
    # && apt install --no-install-recommends -y thunar thunar-archive-plugin thunar-gtkhash thunar-volman
    # && apt install -y --no-install-recommends chromium-browser chromium-browser-l10n chromium-bsu-data chromium-codecs-ffmpeg \
    # Editor && IDE
    # && apt install -y --no-install-recommends mousepad geany
    # Install sound dev 暂时用不到
    # && apt install -y --no-install-recommends libasound2-dev libwebkit2gtk-4.0-dev
    # && apt install -y --fix-missing \
    && apt autoremove -y \
    && apt-get autoclean -y \
    && rm -fr /var/lib/apt/lists/*
