#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-10-20 00:07:29
 # @LastEditTime: 2021-10-20 00:51:52
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/boxs/unity/bootstrap.sh
###

apt update -y
apt install -y --no-install-recommends x11vnc dbus dbus-x11 x11-utils xauth alsa-utils xvfb zenity supervisor
apt install -y --no-install-recommends mesa-utils libgl1-mesa-dri xserver-xorg-video-fbdev xserver-xorg-video-vesa
apt install -y --no-install-recommends git zsh locales xinit net-tools ttf-ubuntu-font-family ttf-wqy-zenhei
apt install -y --no-install-recommends unity unity-control-center unity-lens-applications unity-lens-files unity-scopes-runner unity-session
apt install -y --no-install-recommends yelp gvfs-bin lightdm nautilus notify-osd software-properties-common
apt install -y --no-install-recommends usbutils wireless-tools wpasupplicant xdg-user-dirs xdg-user-dirs-gtk
apt install -y --no-install-recommends fonts-freefont-ttf fonts-urw-base35 ghostscript libatk-adaptor libuuid-perl
apt install -y --no-install-recommends ubuntu-release-upgrader-core ubuntu-system-service ubuntu-advantage-tools ubuntu-artwork ubuntu-drivers-common ubuntu-release-upgrader-core ubuntu-release-upgrader-gtk ubuntu-settings ubuntu-sounds ubuntu-wallpapers ubuntu-wallpapers-focal ubuntu-release-upgrader-gtk ubuntu-settings ubuntu-sounds
apt install -y --no-install-recommends python3-aptdaemon python3-colorama python3-dateutil python3-debconf python3-debian python3-defer python3-distro-info python3-distupgrade python3-ibus-1.0 python3-macaroonbakery python3-nacl python3-protobuf python3-pymacaroons python3-rfc3339 python3-software-properties python3-tz python3-update-manager python3-xkit python3-yaml python3-aptdaemon.gtk3widgets python3-click
apt install -y --no-install-recommends python3 python3-pip gedit zip unzip xorg zenity rfkill ca-certificates genisoimage file-roller eog
apt install -y --no-install-recommends pkg-config yelp xz-utils upower alsa-base alsa-utils anacron
apt install -y --no-install-recommends update-manager update-manager-core update-notifier update-notifier-common
apt install -y --no-install-recommends ubuntu-unity-desktop


pip install numpy websockify xdg -i https://mirrors.aliyun.com/pypi/simple/

locale-gen en_US.UTF-8
mkdir -p /tmp/.deps
cd /tmp/.deps
wget -c https://cloudflying-generic.pkg.coding.net/storage/mirrors/pkgs/tigervnc/tigervnc-1.10.0.x86_64.tar.gz
# wget -c https://cloudflying-generic.pkg.coding.net/storage/mirrors/pkgs/websockify/websockify-0.10.0.tar.gz
wget -c https://cloudflying-generic.pkg.coding.net/storage/mirrors/pkgs/novnc/noVNC-1.2.0.tar.gz
tar -xf tigervnc-1.10.0.x86_64.tar.gz
cp -fr tigervnc-1.10.0.x86_64/* /
# tar -xf websockify*.tar.gz
# cp -fr websockify-0.10.0 /opt/websockify
tar -xf noVNC-1.2.0.tar.gz
cp -fr noVNC-1.2.0 /opt/novnc
cd && rm -fr /tmp/.deps
cp /opt/novnc/vnc.html /opt/novnc/index.html

USER='boxs'
PASSWD='boxs'

useradd -d /home/${USER} -m -s /bin/zsh ${USER}
echo "${USER}:${PASSWD}" | chpasswd
echo "root:${PASSWD}" | chpasswd
echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
git clone --depth 1 https://gitee.com/mirr/oh-my-zsh.git ${HOME_DIR}/.oh-my-zsh
cp ${HOME_DIR}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME_DIR}/.zshrc
sed -i 's/ZSH_THEME.*/ZSH_THEME="strug"/g' ${HOME_DIR}/.zshrc
