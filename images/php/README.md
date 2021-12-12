# Docker PHP Images

## 版本信息
- php 5.6 7.3 7.4 8.0 8.1

Nginx + PHP + Mysql/MariaDB

## alpine include php version

| Alpine | php                 | Nginx     | Redis     | Memcached |     |
| ------ | ------------------- | --------- | --------- | --------- | --- |
| 3.5    | 5.6.38-r0,7.0.33-r0 | 1.10.3-r1 | 3.2.12-r0 | 1.4.33-r2 |     |
| 3.6    | 5.6.40,7.1.17-r0    | 1.12.2-r2 | 3.2.12-r0 | 1.4.36-r2 |     |
| 3.7    | 5.6.40,7.1.33       | 1.12.2-r4 | 4.0.14-r0 | 1.5.6-r0  |     |
| 3.8    | 5.6.40,7.2.26       | 1.14.2-r2 | 4.0.14-r0 | 1.5.8-r0  |     |
| 3.9    | 7.2.33              | 1.14.2-r5 | 4.0.14-r0 | 1.5.12-r0 |     |
| 3.10   | 7.3.14              | 1.16.1    | 5.0.11-r0 | 1.5.16-r0 |     |
| 3.11   | 7.3.2               | 1.16.1    | 5.0.14-r0 | 1.5.20-r0 |     |
| 3.12   | 7.3.32              | 1.18.0    | 5.0.14-r0 | 1.6.6-r0  |     |
| 3.13   | 7.4.24，8.0.12      | 1.18.0    | 6.0.16-r0 | 1.6.9-r0  |     |
| 3.14   | 7.4.25，8.0.12      | 1.20.1    | 6.2.6-r0  | 1.6.9-r0  |     |
| edge   | 7.4.25，8.0.12      | 1.20.1    | 6.2.6-r0  | 1.6.12-r0 |     |

## TODO
- BuyPass、ZeroSSL SSL证书
- 时间同步
- 时区修改中国
- oracle-instantclient basic sdk sqlplus

```shell

    if [ $Mem -le 3000 ]; then
      sed -i "s@^pm.max_children.*@pm.max_children = $(($Mem/3/20))@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.start_servers.*@pm.start_servers = $(($Mem/3/30))@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = $(($Mem/3/40))@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = $(($Mem/3/20))@" ${php_install_dir}/etc/php-fpm.conf
    elif [ $Mem -gt 3000 -a $Mem -le 4500 ]; then
      sed -i "s@^pm.max_children.*@pm.max_children = 50@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.start_servers.*@pm.start_servers = 30@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = 20@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = 50@" ${php_install_dir}/etc/php-fpm.conf
    elif [ $Mem -gt 4500 -a $Mem -le 6500 ]; then
      sed -i "s@^pm.max_children.*@pm.max_children = 60@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.start_servers.*@pm.start_servers = 40@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = 30@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = 60@" ${php_install_dir}/etc/php-fpm.conf
    elif [ $Mem -gt 6500 -a $Mem -le 8500 ]; then
      sed -i "s@^pm.max_children.*@pm.max_children = 70@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.start_servers.*@pm.start_servers = 50@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = 40@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = 70@" ${php_install_dir}/etc/php-fpm.conf
    elif [ $Mem -gt 8500 ]; then
      sed -i "s@^pm.max_children.*@pm.max_children = 80@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.start_servers.*@pm.start_servers = 60@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = 50@" ${php_install_dir}/etc/php-fpm.conf
      sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = 80@" ${php_install_dir}/etc/php-fpm.conf
    fi

  # Configure Xdebug
  echo "xdebug.remote_enable = 1" >> /etc/php/5.6/mods-available/xdebug.ini
  echo "xdebug.remote_connect_back = 1" >> /etc/php/5.6/mods-available/xdebug.ini
  echo "xdebug.remote_port = 9000" >> /etc/php/5.6/mods-available/xdebug.ini
  echo "xdebug.max_nesting_level = 512" >> /etc/php/5.6/mods-available/xdebug.ini
  echo "opcache.revalidate_freq = 0" >> /etc/php/5.6/mods-available/opcache.ini

  # Configure php.ini for CLI
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/5.6/cli/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/5.6/cli/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/5.6/cli/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/5.6/cli/php.ini

  # Configure php.ini for FPM
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/5.6/fpm/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/5.6/fpm/php.ini
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/5.6/fpm/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/5.6/fpm/php.ini
  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/5.6/fpm/php.ini
  sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/5.6/fpm/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/5.6/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/5.6/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/5.6/fpm/php.ini

  printf "[curl]\n" | tee -a /etc/php/5.6/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/5.6/fpm/php.ini

  # Configure FPM
  sed -i "s/user = www-data/user = vagrant/" /etc/php/5.6/fpm/pool.d/www.conf
  sed -i "s/group = www-data/group = vagrant/" /etc/php/5.6/fpm/pool.d/www.conf
  sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/5.6/fpm/pool.d/www.conf
  sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/5.6/fpm/pool.d/www.conf
  sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/5.6/fpm/pool.d/www.conf

  # Configure php.ini for CLI
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/cli/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/cli/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0/cli/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/cli/php.ini

  # Configure Xdebug
  echo "xdebug.remote_enable = 1" >> /etc/php/7.0/mods-available/xdebug.ini
  echo "xdebug.remote_connect_back = 1" >> /etc/php/7.0/mods-available/xdebug.ini
  echo "xdebug.remote_port = 9000" >> /etc/php/7.0/mods-available/xdebug.ini
  echo "xdebug.max_nesting_level = 512" >> /etc/php/7.0/mods-available/xdebug.ini
  echo "opcache.revalidate_freq = 0" >> /etc/php/7.0/mods-available/opcache.ini

  # Configure php.ini for FPM
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/fpm/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/fpm/php.ini
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0/fpm/php.ini
  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.0/fpm/php.ini
  sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.0/fpm/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/7.0/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.0/fpm/php.ini
  printf "[curl]\n" | tee -a /etc/php/7.0/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.0/fpm/php.ini

  # Configure FPM
  sed -i "s/user = www-data/user = vagrant/" /etc/php/7.0/fpm/pool.d/www.conf
  sed -i "s/group = www-data/group = vagrant/" /etc/php/7.0/fpm/pool.d/www.conf
  sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/7.0/fpm/pool.d/www.conf
  sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/7.0/fpm/pool.d/www.conf
  sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.0/fpm/pool.d/www.conf

  # Configure php.ini for CLI
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.1/cli/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.1/cli/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.1/cli/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.1/cli/php.ini

  # Configure Xdebug
  echo "xdebug.remote_enable = 1" >> /etc/php/7.1/mods-available/xdebug.ini
  echo "xdebug.remote_connect_back = 1" >> /etc/php/7.1/mods-available/xdebug.ini
  echo "xdebug.remote_port = 9000" >> /etc/php/7.1/mods-available/xdebug.ini
  echo "xdebug.max_nesting_level = 512" >> /etc/php/7.1/mods-available/xdebug.ini
  echo "opcache.revalidate_freq = 0" >> /etc/php/7.1/mods-available/opcache.ini

  # Configure php.ini for FPM
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.1/fpm/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.1/fpm/php.ini
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.1/fpm/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.1/fpm/php.ini
  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.1/fpm/php.ini
  sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.1/fpm/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.1/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/7.1/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.1/fpm/php.ini
  printf "[curl]\n" | tee -a /etc/php/7.1/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.1/fpm/php.ini

  # Configure FPM
  sed -i "s/user = www-data/user = vagrant/" /etc/php/7.1/fpm/pool.d/www.conf
  sed -i "s/group = www-data/group = vagrant/" /etc/php/7.1/fpm/pool.d/www.conf
  sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/7.1/fpm/pool.d/www.conf
  sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/7.1/fpm/pool.d/www.conf
  sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.1/fpm/pool.d/www.conf

  # Configure php.ini for CLI
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/cli/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/cli/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/cli/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.2/cli/php.ini

  # Configure Xdebug
  echo "xdebug.mode = debug" >> /etc/php/7.2/mods-available/xdebug.ini
  echo "xdebug.discover_client_host = true" >> /etc/php/7.2/mods-available/xdebug.ini
  echo "xdebug.client_port = 9003" >> /etc/php/7.2/mods-available/xdebug.ini
  echo "xdebug.max_nesting_level = 512" >> /etc/php/7.2/mods-available/xdebug.ini
  echo "opcache.revalidate_freq = 0" >> /etc/php/7.2/mods-available/opcache.ini

  # Configure php.ini for FPM
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/fpm/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/fpm/php.ini
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.2/fpm/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/fpm/php.ini
  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.2/fpm/php.ini
  sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.2/fpm/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.2/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/7.2/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.2/fpm/php.ini
  printf "[curl]\n" | tee -a /etc/php/7.2/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.2/fpm/php.ini

  # Configure FPM
  sed -i "s/user = www-data/user = vagrant/" /etc/php/7.2/fpm/pool.d/www.conf
  sed -i "s/group = www-data/group = vagrant/" /etc/php/7.2/fpm/pool.d/www.conf

  sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/7.2/fpm/pool.d/www.conf
  sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/7.2/fpm/pool.d/www.conf
  sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.2/fpm/pool.d/www.conf

  # Configure php.ini for CLI
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/cli/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/cli/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/cli/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.3/cli/php.ini

  # Configure Xdebug
  echo "xdebug.mode = debug" >> /etc/php/7.3/mods-available/xdebug.ini
  echo "xdebug.discover_client_host = true" >> /etc/php/7.3/mods-available/xdebug.ini
  echo "xdebug.client_port = 9003" >> /etc/php/7.3/mods-available/xdebug.ini
  echo "xdebug.max_nesting_level = 512" >> /etc/php/7.3/mods-available/xdebug.ini
  echo "opcache.revalidate_freq = 0" >> /etc/php/7.3/mods-available/opcache.ini

  # Configure php.ini for FPM
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/fpm/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/fpm/php.ini
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.3/fpm/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/fpm/php.ini
  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.3/fpm/php.ini
  sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.3/fpm/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.3/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/7.3/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.3/fpm/php.ini
  printf "[curl]\n" | tee -a /etc/php/7.3/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.3/fpm/php.ini

  # Configure FPM
  sed -i "s/user = www-data/user = vagrant/" /etc/php/7.3/fpm/pool.d/www.conf
  sed -i "s/group = www-data/group = vagrant/" /etc/php/7.3/fpm/pool.d/www.conf
  sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/7.3/fpm/pool.d/www.conf
  sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/7.3/fpm/pool.d/www.conf
  sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.3/fpm/pool.d/www.conf

  # Configure php.ini for CLI
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.4/cli/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.4/cli/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.4/cli/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.4/cli/php.ini

  # Configure Xdebug
  echo "xdebug.mode = debug" >> /etc/php/7.4/mods-available/xdebug.ini
  echo "xdebug.discover_client_host = true" >> /etc/php/7.4/mods-available/xdebug.ini
  echo "xdebug.client_port = 9003" >> /etc/php/7.4/mods-available/xdebug.ini
  echo "xdebug.max_nesting_level = 512" >> /etc/php/7.4/mods-available/xdebug.ini
  echo "opcache.revalidate_freq = 0" >> /etc/php/7.4/mods-available/opcache.ini

  # Configure php.ini for FPM
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.4/fpm/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.4/fpm/php.ini
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.4/fpm/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.4/fpm/php.ini
  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.4/fpm/php.ini
  sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.4/fpm/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.4/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/7.4/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.4/fpm/php.ini
  printf "[curl]\n" | tee -a /etc/php/7.4/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.4/fpm/php.ini

  # Configure FPM
  sed -i "s/user = www-data/user = vagrant/" /etc/php/7.4/fpm/pool.d/www.conf
  sed -i "s/group = www-data/group = vagrant/" /etc/php/7.4/fpm/pool.d/www.conf
  sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/7.4/fpm/pool.d/www.conf
  sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/7.4/fpm/pool.d/www.conf
  sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.4/fpm/pool.d/www.conf

  # Configure php.ini for CLI
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/8.1/cli/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/8.1/cli/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/8.1/cli/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/8.1/cli/php.ini

  # Configure Xdebug
  echo "xdebug.mode = debug" >> /etc/php/8.1/mods-available/xdebug.ini
  echo "xdebug.discover_client_host = true" >> /etc/php/8.1/mods-available/xdebug.ini
  echo "xdebug.client_port = 9003" >> /etc/php/8.1/mods-available/xdebug.ini
  echo "xdebug.max_nesting_level = 512" >> /etc/php/8.1/mods-available/xdebug.ini
  echo "opcache.revalidate_freq = 0" >> /etc/php/8.1/mods-available/opcache.ini

  # Configure php.ini for FPM
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/8.1/fpm/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/8.1/fpm/php.ini
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/8.1/fpm/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/8.1/fpm/php.ini
  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/8.1/fpm/php.ini
  sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/8.1/fpm/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/8.1/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/8.1/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/8.1/fpm/php.ini
  printf "[curl]\n" | tee -a /etc/php/8.1/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/8.1/fpm/php.ini

  # Configure FPM
  sed -i "s/user = www-data/user = vagrant/" /etc/php/8.1/fpm/pool.d/www.conf
  sed -i "s/group = www-data/group = vagrant/" /etc/php/8.1/fpm/pool.d/www.conf
  sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/8.1/fpm/pool.d/www.conf
  sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/8.1/fpm/pool.d/www.conf
  sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/8.1/fpm/pool.d/www.conf

  # Set Some PHP CLI Settings
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/8.0/cli/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/8.0/cli/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/8.0/cli/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/8.0/cli/php.ini

  # Setup Some PHP-FPM Options
  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/8.0/fpm/php.ini
  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/8.0/fpm/php.ini
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/8.0/fpm/php.ini
  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/8.0/fpm/php.ini
  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/8.0/fpm/php.ini
  sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/8.0/fpm/php.ini
  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/8.0/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/8.0/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/8.0/fpm/php.ini

  printf "[curl]\n" | tee -a /etc/php/8.0/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/8.0/fpm/php.ini

  # Disable XDebug On The CLI
  sudo phpdismod -s cli xdebug

  # Set The Nginx & PHP-FPM User
  sed -i "s/user www-data;/user vagrant;/" /etc/nginx/nginx.conf
  sed -i "s/# server_names_hash_bucket_size.*/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf

  sed -i "s/user = www-data/user = vagrant/" /etc/php/8.0/fpm/pool.d/www.conf
  sed -i "s/group = www-data/group = vagrant/" /etc/php/8.0/fpm/pool.d/www.conf

  sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/8.0/fpm/pool.d/www.conf
  sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/8.0/fpm/pool.d/www.conf
  sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/8.0/fpm/pool.d/www.conf

    # 去除所有被禁用的函数
    sed -i 's/disable_functions =.*/disable_functions =/g' /usr/local/php/etc/php.ini
    # 启用 scandir 函数
    sed -i 's/,scandir//g' /usr/local/php/etc/php.ini
    # 启用 exec 函数
    sed -i 's/,exec//g' /usr/local/php/etc/php.ini

sed -i 's/memory_limit =.*/memory_limit = 512M/g' 					"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/max_execution_time =.*/max_execution_time = 300/g' 		"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/max_file_uploads =.*/max_file_uploads = 128/g' 			"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/post_max_size =.*/post_max_size = 4096M/g' 				"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 4096M/g' 	"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/;date.timezone =.*/date.timezone = "Asia\/Shanghai"/g' 	"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/date.timezone =.*/date.timezone = "Asia\/Shanghai"/g' 	"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' 				"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/short_open_tag = .*/short_open_tag = On/g' 				"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/display_errors = .*/display_errors = On/g' 				"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/error_reporting = .*/error_reporting = On/g' 				"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/display_startup_errors =.*/display_startup_errors = On/g' "/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/log_errors =.*/log_errors = On/g' 						"/usr/local/boxs/php/${ver}/etc/php.ini"
sed -i 's/default_charset =.*/default_charset = "UTF-8"/g' 			"/usr/local/boxs/php/${ver}/etc/php.ini"

```


# delete any logs that have built up during the install
find /var/log/ -name *.log -exec rm -f {} \;


# Install ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip -d /usr/local/bin
rm -rf ngrok-stable-linux-amd64.zip

https://github.com/mailhog/MailHog

# Configure Beanstalkd
sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd


  update-alternatives --set php /usr/bin/php8.0
  update-alternatives --set php-config /usr/bin/php-config8.0
  update-alternatives --set phpize /usr/bin/phpize8.0


```shell
  # Install Global Packages
  sudo su vagrant <<'EOF'
  /usr/local/bin/composer global require "laravel/envoy=^2.0"
  /usr/local/bin/composer global require "laravel/installer=^4.0.2"
  /usr/local/bin/composer global require "laravel/spark-installer=dev-master"
  /usr/local/bin/composer global require "slince/composer-registry-manager=^2.0"
  /usr/local/bin/composer global require tightenco/takeout
EOF

  # Install wp-cli
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp

  # Install Drush Launcher.
  curl --silent --location https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar --output drush.phar
  chmod +x drush.phar
  mv drush.phar /usr/local/bin/drush
  drush self-update

  # Install Drupal Console Launcher.
  curl --silent --location https://drupalconsole.com/installer --output drupal.phar
  chmod +x drupal.phar
  mv drupal.phar /usr/local/bin/drupal

  # Add Composer Global Bin To Path
  printf "\nPATH=\"$(sudo su - vagrant -c 'composer config -g home 2>/dev/null')/vendor/bin:\$PATH\"\n" | tee -a /home/vagrant/.profile

/usr/bin/npm install -g npm
/usr/bin/npm install -g gulp-cli
/usr/bin/npm install -g bower
/usr/bin/npm install -g yarn
/usr/bin/npm install -g grunt-cli
beanstalkd postgresql

  # Configure MySQL Password Lifetime
  echo "default_password_lifetime = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf

  # Configure MySQL Remote Access
  sed -i '/^bind-address/s/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

    # Configure MySQL 8 Remote Access and Native Pluggable Authentication
  cat > /etc/mysql/conf.d/mysqld.cnf << EOF
[mysqld]
bind-address = 0.0.0.0
default_authentication_plugin = mysql_native_password
EOF

  echo "mysql-server mysql-server/root_password password secret" | debconf-set-selections
  echo "mysql-server mysql-server/root_password_again password secret" | debconf-set-selections

  mysql --user="root" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'secret';"
  mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;"
  mysql --user="root" -e "CREATE USER 'homestead'@'0.0.0.0' IDENTIFIED BY 'secret';"
  mysql --user="root" -e "CREATE USER 'homestead'@'%' IDENTIFIED BY 'secret';"
  mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'homestead'@'0.0.0.0' WITH GRANT OPTION;"
  mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'homestead'@'%' WITH GRANT OPTION;"
  mysql --user="root" -e "FLUSH PRIVILEGES;"
  mysql --user="root" -e "CREATE DATABASE homestead character set UTF8mb4 collate utf8mb4_bin;"

  mysql --user="root" -e "GRANT ALL ON *.* TO root@'0.0.0.0' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
  service mysql restart

  mysql --user="root" -e "CREATE USER IF NOT EXISTS 'homestead'@'0.0.0.0' IDENTIFIED BY 'secret';"
  mysql --user="root" -e "GRANT ALL ON *.* TO 'homestead'@'0.0.0.0' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
  mysql --user="root" -e "GRANT ALL ON *.* TO 'homestead'@'%' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
  mysql --user="root" -e "FLUSH PRIVILEGES;"

[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_bin

  # Configure Postgres Remote Access
  sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/13/main/postgresql.conf


```
