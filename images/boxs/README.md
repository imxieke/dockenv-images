## About
boxs -> xfce-base-xfce

## Boxs
>> 一键开箱即用 PHP 开发环境, 后期增加其他环境 如 Python Go Node ...

## Version
- latest
  - cli version dev env
- xfce
  - Ubuntu Xfce4 Desktop Version env
- xfce-arch
  - Archlinux Xfce4 Desktop Version env
- sshd
  - Pure Simple Ubuntu Env, No php Python and more env
- builder
  - Archlinux Builder, only for build Archlinux Package

## TODO
- 优化 Nginx Redis PHP Mysql Memcached Leveldb 环境
- neovim oh-my-zsh 配置个人习惯
- fix systemctl not work inside docker container
- xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
- xfconf-query -c xfwm4 -p /general/theme -s "Numix"
- xfce-theme-manager
- 配置 Neovim zsh 插件


## AUR
- menulibre
- xfonts-wqy
- xfonts-75dpi xfonts-scalable xfonts-cyrillic  fonts-mononoki
-  ttf-ubuntu-font-family xfonts-base xfonts-100dpi
-  rar p7zip-full p7zip-rar
-  qdirstat
-  kazam

## Create AUR
- chromium-codecs-ffmpeg
- chromium-browser-l10n

## pkgs

ubuntu-kylin-software-center
unity-tweak-tool
/opt/google/chrome/chrome --user-data-dir=/root --window-position=0,0 --window-size=1366,748 --force-device-scale-factor=1 --no-default-browser-check --no-first-run --disable-translate
## Cli Apps
- linuxbrew

## Desktop App
- elementary/appcenter
- https://github.com/elementary-tweaks/elementary-tweaks

## 拆包查看文件
ukui-themes

## Sound
```
#set ALSA sound to HDMI output
sudo amixer cset numid=3 2
sudo amixer cset numid=1 100%

# run applications in the background

echo "starting pulseaudio ..."
sudo pulseaudio --system --high-priority --no-cpu-limit -v -L 'module-alsa-sink device=plughw:0,1' >/dev/null 2>&1 &


## Chrome
if [ -z "$ALSADEV" ]; then
    zenity --error --text "To support audio, please read README.md and run container with --device /dev/snd -e ALSADEV=..."
    exit 1
fi

exec /usr/bin/google-chrome --no-sandbox --alsa-output-device="$ALSADEV" "$@"

```

## TODO
- 考虑将常用程序写在脚本内 使用时一键安装
- anbox 找一个替代品
- uengine

## Feature
- Web Server
	- [Nginx](https://github.com/nginx/nginx)
	- [OpenRestry](https://github.com/openresty/openresty)
	-[Tengine](https://github.com/alibaba/tengine)
- golang
- nodejs
- python
- ruby
- rust
- dotnet
- code-server (VSCode Web Version)

## TODO
- fix PATH
- https://github.com/elementary

https://flathub.org/repo/
https://dl.flathub.org/repo/appstream/
https://flathub.org/repo/appstream/
https://flathub.org/beta-repo/appstream/org.gimp.GIMP.flatpakref
https://nightly.gnome.org/repo/appstream/org.gimp.GIMP.flatpakref

https://rpmfusion.org/

fastly.cdn.snapcraft.io
darkbowser.canonical.com
canonical-bos01.cdn.snapcraft.io

https://api.snapcraft.io/api/v1/snaps/download/99T7MUlRhtI3U0QFgl5mXXESAiSwt776_11993.snap


## 目录注释
- 一般有 ~/ /usr /usr/local 三个位置存放安装文件
- ~/.config/xfce4/panel/launcher-* xfce panel- 的启动器图标 类似桌面的快捷方式
- ~/.local/share/applications
- /usr/local/share/applications
- /usr/share/applications
- /usr/local/share/fonts
- /usr/share/fonts
- ~/.local/share/icons
- /usr/local/share/icons
- /usr/share/icons
