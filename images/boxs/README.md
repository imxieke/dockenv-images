## Boxs
> 一键开箱即用 PHP 开发环境, 后期增加其他环境 如 Python Go Node ...

## Version
- latest
  - `cli` version dev env base debian
  - Components
    - `vscode-server` visual studio code run in web
      - `docker run -d -p 8080:8080 -e CODE_PASSWD=vscode ghcr.io/dockenv/boxs:vscode`
    - `code-server` visual studio code run in web
- xfce
  - Ubuntu Xfce4 Desktop base debian
- vscode
- sshd
  - sshd run on debian nullseye Pure OS Env, No php Python and more env
  - `docker run -d -p 22:22 ghcr.io/dockenv/boxs:sshd`
- builder
  - Archlinux Builder, only for build Archlinux Package

## TODO
- locales 无法找到字符
- Desktop
  - 无声音 pulseaudio

## Env
- doggo nali htop exa
- code-server

## cli
- kotlin
- rust 解压后 1.2G
-
-

```php
echo phpinfo();
```

