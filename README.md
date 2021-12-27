## Cloudflying Docker Images Repo!

## Image list
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
- aerospike   高可用的 K-V类型的Nosql数据库

### WebDriver
- chromedriver
- geckodriver

## TODO
- shadowsocks
- tengine
- Canddy2

## Docker Composer
- 将程序数据 配置文件 日志等目录挂载出来
- varnish
- haproxy
- selenium
- mailhog

```
$ run shadowsocks
docker run -d -p 6443:6443 -e PASSWORD=passwd registry.cn-hongkong.aliyuncs.com/imxieke/shadowsocks
```

```
docker run -d -p 3308:3306 -e MYSQL_ROOT_PASSWORD=19960318 registry.cn-hongkong.aliyuncs.com/imxieke/mysql:latest --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```

## 常见问题

- 加入`docker`用户组
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
- 守护进程
  - superviosr

提供PHP CLI模式独立运行模式参考：`call-websockt` 与 `php-superviosr`。`call-websockt` 是基于[workman](http://www.workerman.net/) 的PHP Socket服务。`php-supervior` 实现基于Supervisor的队列服务。

## 配置 Docker
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

### 协议

The MIT License (MIT)
