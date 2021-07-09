<a name="Edit-a-Docker-Image"></a>
### 编辑 Docker 镜像

1 - 找到你想修改的镜像的 `Dockerfile` ,
<br>
例如： `mysql` 在 `mysql/Dockerfile`.

2 - 按你所要的编辑文件.

3 - 重新构建容器:

```bash
docker-compose build mysql
```

更多信息在容器重建中[点击这里](#Build-Re-build-Containers).

<a name="Build-Re-build-Containers"></a>
### 建立/重建容器

如果你做任何改变 `Dockerfile` 确保你运行这个命令,可以让所有修改更改生效:

```bash
docker-compose build
```

选择你可以指定哪个容器重建(而不是重建所有的容器):

```bash
docker-compose build {container-name}
```

如果你想重建整个容器，你可能需要使用 `--no-cache` 选项  (`docker-compose build --no-cache {container-name}`).

<a name="Add-Docker-Images"></a>
### 增加更多软件 (Docker 镜像)

为了增加镜像（软件）, 编辑 `docker-compose.yml` 添加容器细节， 你需要熟悉 [docker compose 文件语法](https://docs.docker.com/compose/compose-file/).

<a name="View-the-Log-files"></a>
### 查看日志文件
Nginx的日志在 `logs/nginx` 目录

然后查看其它容器日志(MySQL, PHP-FPM,...) 你可以运行:

```bash
docker logs {container-name}
```

<a name="Laravel"></a>
### [Laravel]

<a name="Install-Laravel"></a>
### 从 Docker 镜像安装 Laravel

1 - 首先你需要进入 Workspace 容器.

2 - 安装 Laravel.

例如 使用 Composer

```bash
composer create-project laravel/laravel my-cool-app "5.2.*"
```

> 我们建议使用 `composer create-project` 替换 Laravel 安装器去安装 Laravel.

关于更多 Laravel 安装内容请 [点击这儿](https://laravel.com/docs/master#installing-laravel).


3 - 编辑 `docker-compose.yml` 映射新的应用目录:
系统默认 Laradock 假定 Laravel 应用在 laradock 的父级目录中

更新 Laravel 应用在 `my-cool-app` 目录中, 我们需要用 `../my-cool-app/:/var/www`替换 `../:/var/www` , 如下:

```yaml
    application:
        build: ./application
        volumes:
            - ../my-cool-app/:/var/www
```

4 - 进入目录下继续工作..

```bash
cd my-cool-app
```

5 - 回到 Laradock 安装步骤,看看如何编辑 `.env` 的文件。

<a name="Run-Artisan-Commands"></a>
### 运行 Artisan 命令

你可以从 Workspace 容器运行 artisan 命令和其他终端命令

增加 `--user=laradock` (例如 `docker-compose exec --user=laradock workspace bash`) 作为您的主机的用户创建的文件.


<a name="Use-Redis"></a>
### 使用 Redis
1 - 首先务必用 `docker-compose up` 命令运行 (`redis`) 容器.

```bash
docker-compose up -d redis
```

2 - 打开你的Laravel的 `.env` 文件 然后 配置 `redis` 的 `REDIS_HOST`

```env
REDIS_HOST=redis
```

如果在你的 `.env` 文件没有找到 `REDIS_HOST` 变量。打开数据库配置文件 `config/database.php` 然后用 `redis` 替换默认 IP `127.0.0.1`，例如：


```php
'redis' => [
    'cluster' => false,
    'default' => [
        'host'     => 'redis',
        'port'     => 6379,
        'database' => 0,
    ],
],
```

3 - 启用 Redis 缓存或者开启 Session 管理也在 `.env` 文件中用 `redis` 替换默认 `file` 设置 `CACHE_DRIVER` 和 `SESSION_DRIVER`

```env
CACHE_DRIVER=redis
SESSION_DRIVER=redis
```

4 - 最好务必通过 Composer 安装 `predis/predis` 包 `(~1.0)`:

```bash
composer require predis/predis:^1.0
```

5 - 你可以用以下代码在 Laravel 中手动测试：

```php
\Cache::store('redis')->put('Laradock', 'Awesome', 10);
```

<a name="Use-Mongo"></a>
### 使用 Mongo

1 - 首先在 Workspace 和 PHP-FPM 容器中安装 `mongo`:

    a) 打开 `docker-compose.yml` 文件
    b) 在 Workspace 容器中找到 `INSTALL_MONGO` 选项：
    c) 设置为 `true`
    d) 在 PHP-FPM 容器中找到 `INSTALL_MONGO`
    e) 设置为 `true`

相关配置项如下:

```yml
    workspace:
        build:
            context: ./workspace
            args:
                - INSTALL_MONGO=true
    ...
    php-fpm:
        build:
            context: ./php-fpm
            args:
                - INSTALL_MONGO=true
    ...
```

2 - 重建 `Workspace、PHP-FPM` 容器

```bash
docker-compose build workspace php-fpm
```

3 - 使用 `docker-compose up` 命令运行 MongoDB 容器 (`mongo`)

```bash
docker-compose up -d mongo
```

4 - 在 `config/database.php` 文件添加 MongoDB 的配置项:

```php
'connections' => [

    'mongodb' => [
        'driver'   => 'mongodb',
        'host'     => env('DB_HOST', 'localhost'),
        'port'     => env('DB_PORT', 27017),
        'database' => env('DB_DATABASE', 'database'),
        'username' => '',
        'password' => '',
        'options'  => [
            'database' => '',
        ]
    ],

	// ...

],
```

5 - 打开 Laravel 的 `.env` 文件然后更新以下字段:

- 设置 `DB_HOST` 为 `mongo` 的主机 IP.
- 设置 `DB_PORT` 为 `27017`.
- 设置 `DB_DATABASE` 为 `database`.


6 - 最后务必通过 Composer 安装 `jenssegers/mongodb` 包，添加服务提供者（Laravel Service Provider）


```bash
composer require jenssegers/mongodb
```

更多细节内容 [点击这儿](https://github.com/jenssegers/laravel-mongodb#installation).

7 - 测试:

- 首先让你的模型继承 Mongo 的 Eloquent Model. 查看 [文档](https://github.com/jenssegers/laravel-mongodb#eloquent).
- 进入 Workspace 容器.
- 迁移数据库 `php artisan migrate`.

<a name="PHP"></a>
### [PHP]

<a name="Install-PHP-Extensions"></a>
### 安装 PHP 拓展

安装 PHP 扩展之前,你必须决定你是否需要 `FPM` 或 `CLI`,因为他们安装在不同的容器上,如果你需要两者,则必须编辑两个容器。

PHP-FPM 拓展务必安装在 `php-fpm/Dockerfile-XX`. *(用你 PHP 版本号替换 XX)*.

PHP-CLI 拓展应该安装到 `workspace/Dockerfile`.

<a name="Change-the-PHP-FPM-Version"></a>
### 修改 PHP-FPM 版本
默认运行 **PHP-FPM 7.0** 版本.

>PHP-FPM 负责服务你的应用代码,如果你是计划运行您的应用程序在不同 PHP-FPM 版本上，则不需要更改 PHP-CLI 版本。

#### A) 切换版本 PHP `7.0` 到 PHP `5.6`

1 - 打开 `docker-compose.yml`。

2 - 在PHP容器的 `Dockerfile-70` 文件。

3 - 修改版本号, 用 `Dockerfile-56` 替换 `Dockerfile-70` , 例如:

```txt
php-fpm:
    build:
        context: ./php-fpm
        dockerfile: Dockerfile-70
```

4 - 最后重建PHP容器

```bash
docker-compose build php
```

> 更多关于PHP基础镜像, 请访问 [PHP Docker官方镜像](https://hub.docker.com/_/php/).


#### B) 切换版本 PHP `7.0` 或 `5.6` 到 PHP `5.5`
我们已不在本地支持 PHP5.5，但是你按照以下步骤获取：

1 - 克隆 `https://github.com/laradock/php-fpm`.

2 - 重命名 `Dockerfile-56` 为 `Dockerfile-55`.

3 - 编辑文件 `FROM php:5.6-fpm` 为 `FROM php:5.5-fpm`.

4 - 从 `Dockerfile-55` 构建镜像.

5 - 打开 `docker-compose.yml` 文件.

6 - 将 `php-fpm` 指向你的 `Dockerfile-55` 文件.


<a name="Change-the-PHP-CLI-Version"></a>
### 修改 PHP-CLI 版本
默认运行 **PHP-CLI 7.0** 版本

>说明: PHP-CLI 只用于执行 Artisan 和 Composer 命令，不服务于你的应用代码，这是 PHP-FPM 的工作，所以编辑 PHP-CLI 的版本不是很重要。
PHP-CLI 安装在 Workspace 容器，改变 PHP-CLI 版本你需要编辑 `workspace/Dockerfile`.
现在你必须手动修改 PHP-FPM 的 `Dockerfile` 或者创建一个新的。 (可以考虑贡献功能).

<a name="Install-xDebug"></a>
### 安装 xDebug

1 - 首先在 Workspace 和 PHP-FPM 容器安装 `xDebug`:

    a) 打开 `docker-compose.yml` 文件
    b) 在 Workspace 容器中找到 `INSTALL_XDEBUG` 选项
    c) 改为 `true`
    d) 在 PHP-FPM 容器中找到 `INSTALL_XDEBUG ` 选项
    e) 改为 `true`

例如:

```yml
    workspace:
        build:
            context: ./workspace
            args:
                - INSTALL_XDEBUG=true
    ...
    php-fpm:
        build:
            context: ./php-fpm
            args:
                - INSTALL_XDEBUG=true
    ...
```

2 - 重建容器 `docker-compose build workspace php-fpm`

<a name="Misc"></a>
### [Misc]

<a name="Use-custom-Domain"></a>
### 使用自定义域名 (替换 Docker 的 IP)

假定你的自定义域名是 `laravel.test`

1 - 打开 `/etc/hosts` 文件添加以下内容，映射你的 localhost 地址 `127.0.0.1` 为 `laravel.test` 域名
```bash
127.0.0.1    laravel.test
```

2 - 打开你的浏览器访问 `{http://laravel.test}`

你可以在 nginx 配置文件自定义服务器名称,如下:

```conf
server_name laravel.test;
```

<a name="Enable-Global-Composer-Build-Install"></a>
### 安装全局 Composer 命令

为启用全局 Composer Install 在容器构建中允许你安装 composer 的依赖，然后构建完成后就是可用的。

1 - 打开 `docker-compose.yml` 文件

2 - 在 Workspace 容器找到 `COMPOSER_GLOBAL_INSTALL` 选项并设置为 `true`

例如:

```yml
    workspace:
        build:
            context: ./workspace
            args:
                - COMPOSER_GLOBAL_INSTALL=true
    ...
```
3 - 现在特价你的依赖关系到 `workspace/composer.json`

4 - 重建 Workspace 容器 `docker-compose build workspace`

<a name="Install-Prestissimo"></a>
### 安装 Prestissimo

[Prestissimo](https://github.com/hirak/prestissimo) 是一个平行安装功能的 composer 插件。

1 - 在安装期间，使全局 Composer Install 正在运行:

    点击这个 [启用全局 Composer 构建安装](#Enable-Global-Composer-Build-Install) 然后继续步骤1、2.

2 - 添加 prestissimo 依赖到 Composer:

a - 现在打开 `workspace/composer.json` 文件

b - 添加 `"hirak/prestissimo": "^0.3"` 依赖

c - 重建 Workspace 容器 `docker-compose build workspace`
