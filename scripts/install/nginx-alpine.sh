#!/usr/bin/env bash
./configure --prefix=/usr/local/nginx \
            --user=www \
            --group=www \
            --with-http_stub_status_module \
            --with-http_v2_module \
            --with-http_ssl_module \
            --with-ipv6 \
            --with-http_gzip_static_module \
            --with-http_realip_module \
            --with-http_flv_module \
            --with-openssl=../openssl-1.0.2h \
            --with-pcre=../pcre-8.39 \
            --with-pcre-jit \
            --add-module=../ngx_cache_purge-2.3

./configure --prefix=/opt/verynginx/openresty \
            --user=nginx \
            --group=nginx \
            --with-http_v2_module \
            --with-http_sub_module \
            --with-http_stub_status_module \
            --with-luajit
# modules
# nginx-module-xslt nginx-module-geoip nginx-module-image-filter
