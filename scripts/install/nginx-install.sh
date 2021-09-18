#!/usr/bin/env sh

NGINX_RTMP_VERSION=1.2.1
NGINX_HTTP_GOOGLE_FILTER_VERSION=0.2.0

# https://github.com/nginx/njs
# https://github.com/nginx/unit
# http://nginx.org/en/docs/njs/index.html
# https://unit.nginx.org/installation/#m_esfab5w5rpozqxdpek62zwqjbt5r9pj6y1noiorg4-packagesnginxorg
# https://hub.docker.com/_/nginx?tab=description&page=1&ordering=last_updated&name=alpine
# https://www.nginx.com/resources/wiki/modules/
# https://github.com/search?q=nginx+module&ref=opensearch
# https://docs.nginx.com/nginx/admin-guide/dynamic-modules/dynamic-modules/
# https://github.com/kaltura/nginx-vod-module
# https://github.com/aperezdc/ngx-fancyindex
# https://github.com/ZigzagAK/lua-shared-dict
# https://github.com/chobits/ngx_http_proxy_connect_module
# https://github.com/winshining/nginx-http-flv-module
# https://github.com/wandenberg/nginx-push-stream-module
# https://github.com/fdintino/nginx-upload-module
# https://github.com/openresty/encrypted-session-nginx-module
# https://github.com/vozlt/nginx-module-vts
# https://github.com/openresty/lua-nginx-module
# https://github.com/openresty/lua-resty-memcached
# https://github.com/openresty/lua-resty-mysql


apk add --no-cache \
                libaio-dev \
                gcc \
                libc-dev \
                make \
                openssl-dev \
                pcre-dev \
                zlib-dev \
                linux-headers \
                libxslt-dev \
                gd-dev \
                geoip-dev \
                perl-dev \
                libedit-dev \
                mercurial \
                bash \
                alpine-sdk \
                findutils

./configure --prefix=/etc/nginx \
            --sbin-path=/usr/sbin/nginx \
            --modules-path=/usr/lib/nginx/modules \
            --conf-path=/etc/nginx/nginx.conf \
            --error-log-path=/var/log/nginx/error.log \
            --http-log-path=/var/log/nginx/access.log \
            --pid-path=/var/run/nginx.pid \
            --lock-path=/var/run/nginx.lock \
            --http-client-body-temp-path=/var/cache/nginx/client_temp \
            --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
            --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
            --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
            --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
            --with-perl_modules_path=/usr/lib/perl5/vendor_perl \
            --user=nginx \
            --group=nginx \
            --with-cc-opt='-Os -fomit-frame-pointer -Wimplicit-fallthrough=0' \
            --with-ld-opt=-Wl,--as-needed \
            --add-module=../nginx-rtmp-module-${NGINX_RTMP_VERSION}
            # --add-module=../ngx_http_google_filter_module-${NGINX_HTTP_GOOGLE_FILTER_VERSION}
