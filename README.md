## Cloudflying Docker Images Repo!

## Wait for add Project
- [Gitpod](https://github.com/gitpod-io/gitpod)
- [Theia](https://github.com/eclipse-theia/theia)
- [Code Server](https://github.com/cdr/code-server)
- [Eclipse Che](https://github.com/eclipse/che)
- [Codiad](https://github.com/Codiad/Codiad)
- [C9](https://github.com/c9/core)
# Debian
	stretch(9)

## TODO
- shadowsocks
- php leveldb extension
- go
- go env configure
- base Centos or redhat
  - almalinux
  - cloudlinux
- tengine
- Canddy2
### Run

## Docker Composer
- 将程序数据 配置文件 日志等目录挂载出来
- varnish
- haproxy
- selenium
- mailhog

# TODO ADD Dockerfile
- geth
- openethereum
- opensuuse
- fedora
- hhvm
- /Users/imxieke/.boxs/bin/all/check-person-project-git-status

```
$ run shadowsocks
docker run -d -p 6443:6443 -e PASSWORD=passwd registry.cn-hongkong.aliyuncs.com/imxieke/shadowsocks
```

```
docker run -d -p 3308:3306 -e MYSQL_ROOT_PASSWORD=19960318 registry.cn-hongkong.aliyuncs.com/imxieke/mysql:latest --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```



#### images/name/Dockerfile is latest version image
#### images/name/Dockerfile.dev is dev version image

## Dockenv
> 一键开箱即用 Docker 环境

## 一键运行
`docker-compose up -d`
inotify-tools
phpRedisAdmin
Aerospike 高可用的 K-V类型的Nosql数据库

https://github.com/mozilla/geckodriver

## TODO
- 将 Nginx 配置 文件 氛围 main sec cache 等多个

## Feature
- https/http2
Kibana、Logstash、phpMyAdmin、phpRedisAdmin、AdminMongo
## 组件
- PHP
  - amqp apcu apcu_bc bcmatch bz2 curl calendar cmark dba dom enchant exif fpm gd
  - mbstring mongodb mysql mysqli
  - opcache openssl phpunit pod_mysql redis redis rdkafka
  - soap swoole uuid xdebug xhprof xmlrpc xsl yaml zip
  -  zookeeper
decimal exif ffi gd gettext gmagick
gmp grpc http igbinary imagick imap interbase intl
ldap mailparse mcrypt memcache memcached mongo mongodb
msgpack mssql mysql mysqli oauth odbc opcache opencensus
parallel* pcntl pcov pdo_dblib pdo_firebird pdo_mysql
pdo_odbc pdo_pgsql pdo_sqlsrv pgsql propro protobuf pspell pthreads* raphf rdkafka recode redis shmop snmp snuffleupagus soap sockets solr sqlsrv ssh2 sybase_ct sysvmsg sysvsem sysvshm tdlib* tidy timezonedb uopz uuid wddx
- composer
- npm
- inotify-tools
- https://github.com/mongo-express/mongo-express monog webui

#### 安装扩展
- `docker-php-ext-install -h` 查看可以安装的扩展
- 快速安装扩展命令 `install-php-extensions apcu`
- `docker-php-ext-enable -h` 启用扩展

### 统一设置 **.test** 域名到本地

1.  `brew install dnsmasq`
2. `/usr/local/etc/dnsmasq.conf` 里面配置 ` address=/.test/127.0.0.1`
3. Create a dns resolver：
    ```bash
       sudo mkdir -v /etc/resolver
       sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
    ```

## 常见问题
- 忽略版本问题
`--ignore-platform-reqs`

- 加入`docker`用户组
`sudo gpasswd -a ${USER} docker`

- 进入容器
```sh
docker exec -it php /bin/sh
install-php-extensions apcu
```
- 容器内的php如何连接宿主机MySQL
1.宿主机执行`ifconfig docker0`得到`inet`就是要连接的`ip`地址
```sh
$ ifconfig docker0
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ...
```
2.运行宿主机Mysql命令行
```mysql
 mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
 mysql>flush privileges;
// 其中各字符的含义：
// *.* 对任意数据库任意表有效
// "root" "123456" 是数据库用户名和密码
// '%' 允许访问数据库的IP地址，%意思是任意IP，也可以指定IP
// flush privileges 刷新权限信息
```

-连接MySQL和Redis服务器
这要分两种情况，

第一种情况，在**PHP代码中**。
```php
// 连接MySQL
$dbh = new PDO('mysql:host=mysql;dbname=mysql', 'root', '123456');

// 连接Redis
$redis = new Redis();
$redis->connect('redis', 6379);
```
因为容器与容器是`expose`端口联通的，而且在同一个`networks`下，所以连接的`host`参数直接用容器名称，`port`参数就是容器内部的端口。更多请参考[《docker-compose ports和expose的区别》](https://www.awaimai.com/2138.html)。

第二种情况，**在主机中**通过**命令行**或者**Navicat**等工具连接。主机要连接mysql和redis的话，要求容器必须经过`ports`把端口映射到主机了。以 mysql 为例，`docker-compose.yml`文件中有这样的`ports`配置：`3306:3306`，就是主机的3306和容器的3306端口形成了映射，所以我们可以这样连接：
```bash
$ mysql -h127.0.0.1 -uroot -p123456 -P3306
$ redis-cli -h127.0.0.1
```
这里`host`参数不能用localhost是因为它默认是通过sock文件与mysql通信，而容器与主机文件系统已经隔离，所以需要通过TCP方式连接，所以需要指定IP。

- 查看docker网络
```sh
ifconfig docker0
```
- Docker使用cron定时任务
[Docker使用cron定时任务](https://www.awaimai.com/2615.html)

另外一种,在docker主机上面运行也是可以的.
```
dphp
crontab -e
#每分钟执行
*       *       *       *       *       php /www/localhost/index.php
#或者直接创建一个每分钟执行的sh文件即可
mkdir -p /etc/periodic/1min
crontab -e
*       *       *       *       *       /etc/periodic/1min
$cat <<EOF > /etc/periodic/1min/foo
> #!/bin/sh
> echo "Hello, world"
> EOF
chmod a+x /etc/periodic/1min/foo
#这样就可以直接输出
```

- Docker容器时间
容器时间在.env文件中配置`TZ`变量，所有支持的时区请看[时区列表·维基百科](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)或者[PHP所支持的时区列表·PHP官网](https://www.php.net/manual/zh/timezones.php)。

- 重启 Nginx
```bash
$ docker exec -it nginx nginx -s reload
```
- PHP-FPM日志
大部分情况下，PHP-FPM的日志都会输出到Nginx的日志中，所以不需要额外配置。

另外，建议直接在PHP中打开错误日志：
```php
error_reporting(E_ALL);
ini_set('error_reporting', 'on');
ini_set('display_errors', 'on');
```

如果确实需要，可按一下步骤开启（在容器中）。

1. 进入容器，创建日志文件并修改权限：
    ```bash
    $ docker exec -it php /bin/sh
    $ mkdir /var/log/php
    $ cd /var/log/php
    $ touch php-fpm.error.log
    $ chmod a+w php-fpm.error.log
    ```
2. 主机上打开并修改PHP-FPM的配置文件`conf/php-fpm.conf`，找到如下一行，删除注释，并改值为：
    ```
    php_admin_value[error_log] = /var/log/php/php-fpm.error.log
    ```
3. 重启PHP-FPM容器。

- MySQL日志
因为MySQL容器中的MySQL使用的是`mysql`用户启动，它无法自行在`/var/log`下的增加日志文件。所以，我们把MySQL的日志放在与data一样的目录，即项目的`mysql`目录下，对应容器中的`/var/lib/mysql/`目录。
```bash
slow-query-log-file     = /var/lib/mysql/mysql.slow.log
log-error               = /var/lib/mysql/mysql.error.log
```
以上是mysql.conf中的日志文件的配置。

- Nginx日志
Nginx日志是我们用得最多的日志，所以我们单独放在根目录`log`下。

`log`会目录映射Nginx容器的`/var/log/nginx`目录，所以在Nginx配置文件中，需要输出log的位置，我们需要配置到`/var/log/nginx`目录，如：
```
error_log  /var/log/nginx/nginx.localhost.error.log  warn;
```

这里两个`nginx`，第一个是容器名，第二个是容器中的`nginx`程序。

- 本地项目，通过域名访问不解析问题

  > 目前通过在 **php容器内**，修改 /etc/hosts 解决
  >
  > ```bash
  > docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx # 首先在宿主机中获取 nginx 容器 ip
  > docker exec -it php bash # 进入php容器
  > echo '第一步中返回的ip domain.test' >> /etc/hosts
  > ```

```SHELL

sudo docker run --rm -ti -p 80:80 -p 3306:3306 --name debian_php_dev_env \
      -v {CODE_PATH}:/var/www/{PROJECT_NAME} \
      -v {NGINX_SERVER_CONFIG_FILE}:/etc/nginx/sites-enabled/default \
      -v {SUPERVISOR_CONFIG_FILE}:/etc/supervisor/conf.d/{CONFIG_NAME}.conf \
      kikiyao/debian_php_dev_env start
```
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
$ sudo mkdir -p /etc/docker
$ sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://muehonsf.mirror.aliyuncs.com"]
}
EOF
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
```

1. 配置.env环境参数，一般无需修改默认参数。配置`PHP_FPM_DOMAIN` 支持Nginx容器虚拟主机互通，配置`SUPERVISOR_DOMAIN` 支持Supervisor容器项目互通。[参考这里](https://github.com/laradock/laradock/issues/435)了解容器多个项目内部通信机制。

2. [*] 配置定时任务容器环境参数。默认无定时任务，可以参考`php-crond/crontabs/default.example`开启定时任务。

```shell
   $ cd php-crond/crontabs/
   $ cp default.example default
```
4. [*] 配置Supervisor后台进程处理任务。默认无后台进程处理，参考`php-supervisor/supervisor/default.conf.example` 配置多进程任务。

## 学习文档
[Docker 配置详解](https://www.jianshu.com/p/2217cfed29d7)

[Docker 入门教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)

[Docker 微服务教程](http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html)

### 协议

The MIT License (MIT)

```shell
* * * * * php /var/www/laravel/artisan schedule:run >> /dev/null 2>&1
* docker-compose exec --user=laradock workspace bash
* /usr/sbin/init
* /usr/sbin/php-fpm -c /etc/php.ini -y /etc/php-fpm.conf
```
