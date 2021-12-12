FROM registry.cn-hongkong.aliyuncs.com/boxs/ubuntu:21.04
LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y \
    && apt install -y --no-install-recommends python3 python3-pip python3-apt iso-codes ca-certificates locales supervisor sudo \
    # ctags
    lsb-release openssl apt-transport-https gnupg lsof universal-ctags strace psmisc file apt-utils psutils \
    dnsutils expect \
    && apt install -y --no-install-recommends bat zsh git wget curl httpie axel neovim jq tree screen less iftop enca \
    # Archive COmpress
    && apt install -y --no-install-recommends rpm unar zip unzip bzip2 rar unrar zstd gzip p7zip p7zip-full p7zip-rar cabextract \
    xz-utils \
    && apt install -y --no-install-recommends net-tools procps htop netcat rsync iproute2 whois \
    && apt install -y --no-install-recommends python3-software-properties software-properties-common python3-neovim \
    && apt install -y --no-install-recommends openssh-server openssh-sftp-server \
    && apt install -y --no-install-recommends xinit xauth pkg-config yelp yelp-xsl zenity \
    # dialog Displays user-friendly dialog boxes from shell scripts
    && apt install -y --no-install-recommends ubuntu-mono pavucontrol apulse dialog \
    # 测试是否可以删除 libgl1-mesa-dri xvfb libnss-wrapper mesa-utils
    # xserver-xorg-video-fbdev xserver-xorg-video-vesa xserver-xorg-input-evdev
    && apt install -y --no-install-recommends xorg x11vnc x11-utils dbus dbus-x11  xdg-utils \
    && apt install -y --no-install-recommends xfce4 xfce4-terminal  \
    && apt install -y --no-install-recommends alsamixergui alsa-utils alsa-oss alsa-tools alsa-tools-gui \
    && apt install -y --no-install-recommends xfce4-whiskermenu-plugin xfce4-datetime-plugin xfce4-goodies \
    xfce4-panel-profiles xfce4-screenshooter xfce4-systemload-plugin xfce4-taskmanager  \
    # && apt install -y --no-install-recommends fonts-noto-mono ttf-ubuntu-font-family ttf-wqy-zenhei xfonts-base xfonts-100dpi \
    # xfonts-75dpi xfonts-scalable xfonts-cyrillic ttf-wqy-zenhei fonts-wqy-zenhei fonts-wqy-microhei xfonts-wqy fonts-mononoki \
    # fonts-noto-mono fonts-liberation \
    && pip install numpy websockify -i https://mirrors.aliyun.com/pypi/simple/ \
    # && apt install -y --no-install-recommends openbox openbox-menu \
    # editor 考虑 sublime text 为替代品
    # && apt install -y --no-install-recommends gedit \
    # 暂时不考虑使用
    # && apt install -y --no-install-recommends xrdp xorgxrdp \
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
    && apt install --no-install-recommends -y thunar thunar-archive-plugin thunar-gtkhash thunar-volman
# && apt install -y --no-install-recommends chromium-browser chromium-browser-l10n chromium-bsu-data chromium-codecs-ffmpeg \
# Editor && IDE
# && apt install -y --no-install-recommends mousepad geany
# Install sound dev 暂时用不到
# && apt install -y --no-install-recommends libasound2-dev libwebkit2gtk-4.0-dev
# && apt install -y --fix-missing

CMD ["/bin/bash"]
