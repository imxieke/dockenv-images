## Docker Image

## Dockerfile 介绍
- portainer   docker 容器管理 UI
- thumbor     是一个非常强大的图片处理服务，可以实现图片裁剪、缩放、滤镜，甚至是人脸识别。
- ide-theia   运行在浏览器里的开发环境
- Dejavu      ElasticSearch Web UI
- Graylog   开源的日志聚合、分析、审计、展现和预警工具。功能上和ELK类似,但比 ELK 要简单
- ICEcoder  WebIDE
- Grafana   跨平台的开源的度量分析和可视化工具
- Solr      独立的企业级搜索应用服务器
- mosquitto Eclipse Mosquitto 是一个开源消息代理
- Kibana    日志分析平台 为 Logstash 和 ElasticSearch 提供的日志分析的 Web 接口。可对日志进行搜索、可视化、分析
- minio     分布式存储对象存储方案
- percona   数据库 类似 Mariadb 兼容 mysql
- traefik   反向代理工具 类似 nginx
- sqs       ElasticMQ server + web UI
- Cassandra 开源分布式NoSQL数据库系统
- Manticore database designed specifically for search, including full-text search
- rethinkdb 存储 JSON 文档的分布式数据库
- couthdb   面向文档的数据库管理系统
- mailcatcher  抓取和查看邮件
- jupyterhub Jupyter notebook 的多用户服务器
- Truffle   以太坊的Solidity语言的一套开发框架
- ganache   以太坊节点仿真环境
- ldap      LDAP容器
- nginx-stream  支持4层转发的nginx官方版本
- openresty 支持lua脚本的nginx容器
- tengine       阿里开源nginx版本，支持lua
- Buildbot      Archlinux aur Build Bot
- golang        go language support environment
- h5ai          online file view
- java          java(8) language support environment.
- nextcloud     an open source, self-hosted file share and communication platform, like owncloud.
- owncloud      an open source, self-hosted file sync and share app platform.
- php7          php(7) language support environment  running in alpine include nginx php7!
- rsync         an open source utility that provides fast incremental file transfer.
- sshd          support remote access via ssh ,running in debian buster
- ttyd           Share your terminal over the web

#### Linux/Unix Open System

|  Name | Comments  |
|---|---|
| ALinux  | Aliyun Linux  |
| Alpine  | A minimal Linux  |
| Almalinux  | An Open Source, community owned and governed, forever-free enterprise Linux distribution, compatible with rhel && CentOS |
| Altlinux  | based on RPM Package Manager (RPM)  |
| amazonlinux  | Amazon Distribution,Base RHEL  |
| Archlinux  | A simple, lightweight distribution |
| Cirros  |  |
| Clearlinux  | open source, rolling release Linux distribution |
| Debian  | Debian is a Linux distribution that's composed entirely of free and open-source software. |
| Deepin  | a beautiful open source  GNU/Linux, Base Debian |
| Centos  | Community Enterprise Operating System |
| Fedora  | like RHEL |
| Gentoo  | a highly flexible, source-based Linux distribution. |
| Kali  |  Debian-derived Linux distribution designed for digital forensics and penetration testing. It is maintained and funded by Offensive Security. |
| Manjaro  | based on the Arch Linux |
| Megaia  | community-based Linux distribution |
| Openeuler  | debian-like |
| opensuse  |openSUSE is a project that serves to promote the use of free and open-source software. openSUSE is well known for its Linux distributions |
| Oraclelinux  | based on the rhel |
| Photon  | an open-source minimalist Linux operating system from VMware that is optimized for cloud computing platforms |
| Rockylinux  | based on the rhel |
| rhel  | Red Hat Enterprise Linux operating system |
| Scientific Linux  | based on Red Hat Enterprise Linux |
| Ubuntu  | Ubuntu is a Debian-based Linux operating system based on free software. |


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
