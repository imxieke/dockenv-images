<p align="center"><img src="https://user-images.githubusercontent.com/6483352/175850848-799b1ea1-941c-4e7f-8378-4a0a64dcdad8.png" alt="Dockenv"></p>

<p align="center">
<!-- <a href="https://github.com/imxieke/dockenv/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/imxieke/dockenv"></a> -->
<!-- <a href="https://github.com/imxieke/dockenv/issues"><img src="https://img.shields.io/github/issues/imxieke/dockenv" alt="Issue"></a> -->
<!-- <a href="https://github.com/imxieke/dockenv"><img src="https://img.shields.io/github/license/imxieke/dockenv" alt="License"></a> -->
<h1 style="text-align:center" >Cloudflying Docker Images Repo</h1>
</p>

## Directory or File Comments

| Name | Note |
|---|---|---|
| conf | Docker Container Conf |
| docs | Current Project Document |
| images | Docker Images |
| runtime | Docker runtime Attachment  |
| scripts | Some Docker Tools Scripts |
| dockenv | Docker Images Utils |

## Docker Image
#### OS
- ALinux Aliyun Linux
- Almalinux
- Alpine
- Altlinux
- Archlinux
- Cirros
- Clearlinux
- Debian
- Deepin
- Centos
- Fedora
- Gentoo
- Kali
- Manjaro
- Megaia
- Openeuler
- Oraclelinux
- Photon
- Rockylinux
- Scientific Linux
- Ubuntu

## Rolling Release
- Archlinux
- Alpine Edge
- Debian testing
- Gentoo
- kali kali-rolling (default)
- Manjaro (Base Archlinux)
- opensuse tumbleweed
- solus
  - TODO
  - https://github.com/solus-project
  - https://getsol.us
  - https://github.com/sileshn/SolusWSL
- voidlinux

#### App image
- inotify-tools
- phpRedisAdmin
- aerospike key-value

### WebDriver
- chromedriver
- geckodriver

## TODO
- shadowsocks
- tengine
- Canddy2

## Docker Composer
- mount to local volume for data log etc...
- varnish
- haproxy
- selenium
- mailhog

## Issues

- add user to `docker` group
`sudo usermod -aG ${USER} docker`

## Env
- Web Server
  - [Canndy](https://caddyserver.com)
  - [Nginx](http://nginx.org)
  - Openresty
  - Tengine
- SQL
  - [MYSQL](https://www.mysql.com)
  - [MariaDB](https://mariadb.org)
  - [SQLite](https://www.sqlite.org)
  - [PostGreSQL](https://www.postgresql.org)
  - [MongoDB](https://www.mongodb.com)
- Mysql Manager
  - [PHPMyAdmin](https://www.phpmyadmin.net)
  - [Adminer](https://www.adminer.org)
- NOSQL
  - [Aerospike](https://aerospike.com)
  - [Redis](https://redis.io)
  - [Memcached](https://memcached.org)
- Message Queue (Broker)
  - [RabbitMQ](https://www.rabbitmq.com)
  - [beanstalkd](https://beanstalkd.github.io)
  - [Apache Kafka](http://kafka.apache.org)
- full-text search engine
  - [elastic](https://www.elastic.co)
- Editor
  - [NeoVim](https://neovim.io)
  - [Sublime Text](https://www.sublimetext.com)
  - [Visual Studio Code](https://code.visualstudio.com)
- Git Version Repo
  - [Github](https://github.com)
  - [BitBucket](https://bitbucket.org)
  - [Gitlab](https://about.gitlab.com)
  - [Azure](https://dev.azure.com)
- Daemon
  - superviosr

## Linux Config Docker Mirrors
```bash
# macOS Docker
$ mkdir -p ~/.docker
# Linux Docker
$ sudo mkdir -p /etc/docker
$ sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://muehonsf.mirror.aliyuncs.com"]
}
EOF
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
```

## 学习文档
[Docker 配置详解](https://www.jianshu.com/p/2217cfed29d7)

[Docker 入门教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)

[Docker 微服务教程](http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html)

### License

The MIT License (MIT)
