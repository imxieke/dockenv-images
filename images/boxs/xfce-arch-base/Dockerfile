FROM ghcr.io/dockenv/archlinux:latest
LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"
ENV DEBIAN_FRONTEND=noninteractive

RUN pacman -Syyu --noconfirm \
    && pacman-key --init \
    && pacman-key --populate archlinux \
    # inetutils Provide hostname ftp telnet command etc ...
    # xorg-xrandr 设置分辨率
    && pacman -S --noconfirm dbus exo garcon tumbler ristretto parole inetutils xorg-xrandr xorg-server \
    && pacman -S --noconfirm xfce4-appfinder xfce4-panel xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop xfwm4 \
    xfce4-artwork xfwm4-themes xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-dict xfce4-diskperf-plugin \
    xfce4-eyes-plugin xfce4-mount-plugin xfce4-mpc-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screenshooter \
    xfce4-systemload-plugin xfce4-taskmanager xfce4-time-out-plugin xfce4-timer-plugin xfce4-whiskermenu-plugin \
    # File Manage
    && pacman -S --noconfirm thunar thunar-archive-plugin thunar-volman \
    && pacman -S --noconfirm tigervnc python python-pip python-pynvim openssh dialog \
    && pip install wheel numpy websockify -i https://repo.huaweicloud.com/pypi/simple/ \
    # build desktop require
    && pacman -S --noconfirm supervisor sudo wget curl git neovim tree less zsh bat net-tools \
    && git clone --depth 1 https://e.coding.net/pkgs/oh-my-zsh/oh-my-zsh.git /tmp/oh-my-zsh \
    # && pacman -S --noconfirm expect httpie axel jq screen iftop enca \
    # Archive Compress
    # && pacman -S --noconfirm unarchiver zip unzip bzip2 unrar zstd gzip p7zip xz \
    # && pacman -S --noconfirm procps gnu-netcat htop rsync iproute2 whois \
    # && pacman -S --noconfirm ncdu catfish bleachbit meld synapse fzf remmina strace \
    # && pacman -S --noconfirm sshfs proxychains-ng \
    # Mail Client
    # && pacman -S --noconfirm thunderbird \
    # Downloader qbittorrent-nox ktorrent rtorrent deluge transmission-cli or transmission-gtk or -qt
    # && pacman -S --noconfirm aria2 \
    # && pacman -S --noconfirm qbittorrent \
    # Documents && Office
    # 进入系统后自定义安装
    # Calibre 图书创作工具
    # && pacman -S --noconfirm okular calibre fbreader libreoffice-still libreoffice-still-zh-cn \
    # && pacman -S --noconfirm midori \
    # productivity and creative suite && Image Manipulation
    # && pacman -S --noconfirm calligra gimp gimp-help-zh_cn \
    # && pacman -S --noconfirm krita krita-plugin-gmic \
    # screencast and screenshot
    # kazam 将输入的字符转为 ASCII logo
    # recordmydesktop 命令行版本录屏
    # simplescreenrecorder 录屏
    # && pacman -S --noconfirm shutter asciinema recordmydesktop simplescreenrecorder \
    # FTP Client
    # && pacman -S --noconfirm filezilla \
    # && pacman -S --noconfirm firefox firefox-developer-edition firefox-i18n-zh-cn firefox-developer-edition-i18n-zh-cn \
    # Security
    # && pacman -S --noconfirm clamav clamtk ufw gufw \
    # fonts
    # noto-fonts-cjk 文件过大 292 MB
    # noto-fonts 114M
    # && pacman -S --noconfirm ttf-ubuntu-font-family noto-fonts-emoji wqy-microhei wqy-zenhei wqy-microhei ttf-fira-code ttf-fira-mono ttf-jetbrains-mono woff-fira-code ttf-liberation powerline-fonts \
    && rm -fr /var/cache/pacman/pkg/* \
    && rm -fr /var/lib/pacman/sync/*
