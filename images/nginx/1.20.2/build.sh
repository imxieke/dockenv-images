#!/usr/bin/env sh
###
 # @Author: Cloudflying
 # @Date: 2021-11-19 13:20:23
 # @LastEditTime: 2021-11-19 22:56:48
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/nginx/1.20.2/build.sh
###
NGINX_VERSION='1.20.2'
# NGINX_VERSION='1.21.4'
# Deps
apk add --virtual .deps make gcc g++ autoconf automake git wget findutils
apk add sregex-dev --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
# libxml2-dev
# ./configure: no supported file AIO was found
apk add linux-headers
# libaio-dev
apk add libxslt-dev zlib-dev gd-dev geoip-dev
# 文件较大
apk add czmq-dev libmaxminddb-dev flex bison zstd-dev libressl-dev
fix_conf()
{
    # 使 Nginx 可以直接使用本地已安装 openssl
    sed -i 's/\.openssl\///g' auto/lib/openssl/conf
    sed -i 's/libssl\.a/x86_64-linux-gnu\/libssl\.a/g' auto/lib/openssl/conf
    sed -i 's/libcrypto\.a/x86_64-linux-gnu\/libcrypto\.a/g' auto/lib/openssl/conf
}

mkdir -p /tmp/build/ngx_mod
cd /tmp/build
if [[ ! -f "/tmp/build/nginx-${NGINX_VERSION}" ]]; then
    if [[ ! -f "/tmp/build/nginx-${NGINX_VERSION}.tar.gz" ]]; then
        URL="https://hk.mirrors.xieke.org/Src/nginx/nginx-${NGINX_VERSION}.tar.gz"
        wget -c ${URL}
    fi
    tar -xvf nginx-${NGINX_VERSION}.tar.gz > /dev/null 2>&1
    cd nginx-${NGINX_VERSION} && fix_conf
fi

cd /tmp/build/ngx_mod

# Cache
# git clone --depth 1 https://github.com/nginx-modules/ngx_cache_purge
# git clone --depth 1 https://github.com/openresty/srcache-nginx-module
# git clone --depth 1 https://github.com/wandenberg/nginx-selective-cache-purge-module

# git clone --depth 1 https://github.com/google/nginx-sxg-module
# git clone --depth 1 https://github.com/openresty/lua-nginx-module
# git clone --depth 1 https://github.com/openresty/stream-lua-nginx-module
# git clone --depth 1 https://github.com/openresty/lua-upstream-nginx-module
# git clone --depth 1 https://github.com/openresty/echo-nginx-module
# git clone --depth 1 https://github.com/openresty/stream-echo-nginx-module
# git clone --depth 1 https://github.com/openresty/set-misc-nginx-module
# git clone --depth 1 https://github.com/openresty/headers-more-nginx-module
# git clone --depth 1 https://github.com/openresty/memc-nginx-module
# git clone --depth 1 https://github.com/openresty/array-var-nginx-module
# git clone --depth 1 https://github.com/openresty/encrypted-session-nginx-module

# git clone --depth 1 https://github.com/vision5/ngx_devel_kit
# git clone --depth 1 https://github.com/vision5/ngx_http_set_lang
# git clone --depth 1 https://github.com/vision5/ngx_http_set_hash
# git clone --depth 1 https://github.com/apache/incubator-pagespeed-ngx
# git clone --depth 1 https://github.com/Refinitiv/nginx-sticky-module-ng
# git clone --depth 1 https://github.com/arut/nginx-dav-ext-module
# 流媒体 包含 rtmp 所有功能
# git clone --depth 1 https://github.com/winshining/nginx-http-flv-module
# git clone --depth 1 https://github.com/arut/nginx-rtmp-module
# git clone --depth 1 https://github.com/kaltura/nginx-vod-module
# git clone --depth 1 https://github.com/arut/nginx-live-module
# MPEG-TS Live
# git clone --depth 1 https://github.com/arut/nginx-ts-module

# Compress
git clone --depth 1 https://github.com/google/ngx_brotli
git clone --depth 1 https://github.com/tokers/zstd-nginx-module
# file unzip
# git clone --depth 1 https://github.com/ajax16384/ngx_http_untar_module
# git clone --depth 1 https://github.com/evanmiller/mod_zip

# git clone --depth 1 https://github.com/kaltura/nginx-json-var-module
# git clone --depth 1 https://github.com/nicholaschiasson/ngx_upstream_jdomain
# git clone --depth 1 https://github.com/itoffshore/nginx-upstream-fair
# git clone --depth 1 https://github.com/masterzen/nginx-upload-progress-module
# git clone --depth 1 https://github.com/slact/nchan
# git clone --depth 1 https://github.com/Lax/traffic-accounting-nginx-module
# git clone --depth 1 https://github.com/aperezdc/ngx-fancyindex
# git clone --depth 1 https://github.com/nginx-shib/nginx-http-shibboleth
# git clone --depth 1 https://github.com/AirisX/nginx_cookie_flag_module
# git clone --depth 1 https://github.com/AlticeLabsProjects/nginx-log-zmq
git clone --depth 1 https://github.com/nbs-system/naxsi
# unknow error
# git clone --depth 1 https://github.com/nginx/njs
# git clone --depth 1 https://github.com/kaltura/nginx-secure-token-module
# git clone --depth 1 https://github.com/kaltura/nginx-aggr-module

# function
# git clone --depth 1 https://github.com/kaltura/nginx-parallel-module
git clone --depth 1 https://github.com/nginx-modules/ngx_http_hmac_secure_link_module

# Limit
# git clone --depth 1 https://github.com/nginx-modules/ngx_http_limit_traffic_ratefilter_module

# git clone --depth 1 https://github.com/dvershinin/ngx_dynamic_etag
# IP
git clone --depth 1 https://github.com/ip2location/ip2proxy-nginx
git clone --depth 1 https://github.com/ip2location/ip2location-nginx
git clone --depth 1 https://github.com/leev/ngx_http_geoip2_module

# embed language
# git clone --depth 1 https://github.com/decentfox/nginxpy
# git clone --depth 1 https://github.com/arut/nginx-python-module
# git clone --depth 1 https://github.com/rryqszq4/ngx_php7

# git clone --depth 1 https://github.com/limithit/ngx_dynamic_limit_req_module
# git clone --depth 1 https://github.com/zhouchangxun/ngx_healthcheck_module
# git clone --depth 1 https://github.com/tarantool/nginx_upstream_module

# Security
# Application FireWall
# git clone --depth 1 https://github.com/SpiderLabs/ModSecurity-nginx
# git clone --depth 1 https://github.com/aufi/anddos
# git clone --depth 1 https://github.com/openresty/xss-nginx-module
# git clone --depth 1 https://github.com/ADD-SP/ngx_waf

# server traffic status
# git clone --depth 1 https://github.com/vozlt/nginx-module-sts
# git clone --depth 1 https://github.com/vozlt/nginx-module-stream-sts.git # depen by sts
# git clone --depth 1 https://github.com/zhouchangxun/ngx_stream_upstream_check_module
# git clone --depth 1 https://github.com/psychobilly/ngx_http_json_status_module

# Filter
git clone --depth 1 https://github.com/cuber/ngx_http_google_filter_module
git clone --depth 1 https://github.com/openresty/replace-filter-nginx-module
git clone --depth 1 https://github.com/yaoweibin/ngx_http_substitutions_filter_module

# Other
# git clone --depth 1 https://github.com/wandenberg/nginx-push-stream-module
git clone --depth 1 https://github.com/TeslaGov/ngx-http-auth-jwt-module
# git clone --depth 1 https://github.com/openresty/redis2-nginx-module
# git clone --depth 1 https://github.com/openresty/rds-csv-nginx-module
# git clone --depth 1 https://github.com/openresty/rds-json-nginx-module

if [[ -d '/tmp/build/ngx_mod/ngx_waf' ]]; then
    cd /tmp/build/ngx_mod/ngx_waf && make
    git clone --depth 1 https://github.com/libinjection/libinjection inc/libinjection
fi

if [[ ! -f "/usr/lib/x86_64-linux-gnu/libssl.a" ]]; then
    mkdir -p /usr/lib/x86_64-linux-gnu
    ln -s /usr/lib/libssl.a /usr/lib/x86_64-linux-gnu/libssl.a
    ln -s /usr/lib/libcrypto.a /usr/lib/x86_64-linux-gnu/libcrypto.a
fi

cd /tmp/build/nginx-${NGINX_VERSION}
# fast to get module
# 不想编译的扩展删除扩展目录并注释 git 命令即可
# mod_ops=$(ls ../ngx_mod/ | tr ' ' '\n' | awk  '{print "--add-dynamic-module=../"$1" \\"}' | sed 's#njs#njs\/nginx#g' | sed 's#naxsi#naxsi/naxsi_src#g')
# mod_ops=$(ls ../ngx_mod/ | tr ' ' '\n' | grep -v 'ngx_devel_kit' | grep -v 'ngx_healthcheck_module' | awk  '{print "--add-dynamic-module=../ngx_mod/"$1}' | sed 's#njs#njs\/nginx#g' | sed 's#naxsi#naxsi/naxsi_src#g')
mod_ops=$(ls ../ngx_mod/ | tr ' ' '\n' | grep -v 'ngx_devel_kit' | grep -v 'ngx_healthcheck_module' | awk  '{print "--add-dynamic-module=../ngx_mod/"$1}' | sed 's#naxsi#naxsi/naxsi_src#g')
# LUAJIT_INC=$(find /usr/include/ -maxdepth 1 -name 'luajit*')
# echo $mod_ops;exit
# echo $LUAJIT_INC;exit
# LUAJIT_INC=${LUAJIT_INC}
./configure \
    --prefix=/var/lib/nginx \
    --sbin-path=/usr/sbin/nginx \
    --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --pid-path=/run/nginx/nginx.pid \
    --lock-path=/run/nginx/nginx.lock \
    --http-client-body-temp-path=/var/lib/nginx/tmp/client_body \
    --http-log-path=/var/log/nginx.log \
    --http-proxy-temp-path=/var/lib/nginx/tmp/proxy \
    --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi \
    --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi \
    --http-scgi-temp-path=/var/lib/nginx/tmp/scgi \
    --user=nginx \
    --group=nginx \
    --with-threads \
    --with-file-aio \
    --with-http_addition_module \
    --with-http_auth_request_module \
    --with-http_dav_module \
    --with-http_degradation_module \
    --with-http_image_filter_module=dynamic \
    --with-http_flv_module \
    --with-http_geoip_module=dynamic \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_mp4_module \
    --with-http_random_index_module \
    --with-http_realip_module \
    --with-http_secure_link_module \
    --with-http_ssl_module \
    --with-http_sub_module \
    --with-http_slice_module \
    --with-http_stub_status_module \
    --with-http_v2_module \
    --with-http_xslt_module=dynamic \
    --with-mail=dynamic \
    --with-mail_ssl_module \
    --with-stream=dynamic \
    --with-stream_geoip_module=dynamic \
    --with-stream_realip_module \
    --with-stream_ssl_module \
    --with-stream_ssl_preread_module \
    --with-compat \
    --with-pcre \
    --with-poll_module \
    --with-pcre-jit \
    --with-select_module \
    --with-openssl=/usr
    # --with-perl_modules_path=/usr/lib/perl5/vendor_perl \
    # --with-http_perl_module=dynamic \
    # --with-zlib=/usr
    # ${mod_ops}
    # --add-dynamic-module=../ngx_mod/ngx_devel_kit \
    # --add-module=../ngx_mod/ngx_healthcheck_module \
    # ${mod_ops%?}
    make -j8
