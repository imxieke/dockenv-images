# Docker PHP Images

## Version Infomation
- php
  - 5.6.40 3.8
  - 7.0.33 3.5
  - 7.1.33 3.5
  - 7.2.33 3.5
  - 7.3.33 3.5
  - 7.4.30 edge testing
  - 8.0.20 3.16
  - 8.1.7  3.16
  - 8.2.0 edge testing

## Filter php and components
`apk list | grep '^php81' | sort | grep -Ev 'installed|dbg|apache|cgi|doc|pear|litespeed|dev'| awk -F '-[0-9]' '{print $1}' | tr '\n' ' '`

## php and extension version

| PHP | php                 | Nginx     | Redis     | Memcached |  Swoole   | ioncube  |
| ------ | ------------------- | --------- | --------- | --------- | --- | --- |
| 5.6.40    | 5.6.38,7.0.33       | 1.10.3-r1 | 3.2.12-r0 | 1.4.33-r2 | todo |√|
| 7.0.33 | 5.6.40,7.1.17       | 1.12.2-r2 | 3.2.12-r0 | 1.4.36-r2 |   todo |√|
| 7.1.33  | 5.6.40,7.1.33       | 1.12.2-r4 | 4.0.14-r0 | 1.5.6-r0  |  todo  |√|
| 7.2.33 | 5.6.40,7.2.26       | 1.14.2-r2 | 4.0.14-r0 | 1.5.8-r0  |   todo  |√|
| 7.3.33 | 7.2.33              | 1.14.2-r5 | 4.0.14-r0 | 1.5.12-r0 |   todo  |√|
| 7.4.30 | 7.3.14              | 1.16.1    | 5.0.11-r0 | 1.5.16-r0 |   4.8.10  |√|
| 8.0.12   | 7.3.2               | 1.16.1    | 5.0.14-r0 | 1.5.20-r0 | 4.8.10 |x|
| 8.1.7 | 7.3.33              | 1.18.0    | 5.0.14-r0 | 1.6.6-r0  | 4.8.10 |x|
| 8.2.0  | 7.4.24，8.0.12       | 1.18.0    | 6.0.16-r0 | 1.6.9-r0  | x |x|

>PS: `x` is  Unsupported

## extensions
- php 5.6
  - installed: apc apcu bcmath bz2 calendar Core ctype curl date dba dom enchant ereg exif fileinfo filter ftp gd gettext gmp hash iconv imap intl json ldap libxml mbstring mcrypt mssql mysql mysqli mysqlnd odbc openssl pcntl pcre PDO pdo_dblib pdo_mysql PDO_ODBC pdo_pgsql pdo_sqlite pgsql Phar posix pspell readline Reflection session shmop SimpleXML snmp soap sockets SPL sqlite3 standard suhosin sysvmsg sysvsem sysvshm tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl Zend OPcache zip zlib
  - todo: redis mongo memcached swoole ionCube phalcon ImageMagick GMagick Source Guardian, Xdebug Zend Optimizer, MSSql
- 8.2
  - todo: ImageMagick, ionCube ,OPcache JIT ,Phalcon,Source Guardian,Xdebug,Swoole,Memcache,Memcached


## DEPRECATED
- wddx removed in 7.4.0
