FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

ENV MEMCACHED_VERSION 1.5.12
ENV MEMCACHED_SHA1 f67096ba64b0c47668bcad5b680010c4f8987d4c

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN set -x ; \
	addgroup -g 11211 memcache && adduser -D -u 11211 -G memcache memcache ; \
	apk add --no-cache --virtual .build-deps \
		ca-certificates \
		coreutils \
		cyrus-sasl-dev \
		dpkg-dev dpkg \
		gcc \
		libc-dev \
		libevent-dev \
		libressl \
		linux-headers \
		make \
		perl \
		perl-utils \
		tar \
		wget \
	\
	&& wget -O memcached.tar.gz "https://qcloud.coding.net/u/imxieke/p/Collect/git/blob/master/src/memcached-$MEMCACHED_VERSION.tar.gz" \
	&& echo "$MEMCACHED_SHA1  memcached.tar.gz" | sha1sum -c - \
	&& mkdir -p /usr/src/memcached \
	&& tar -xzf memcached.tar.gz -C /usr/src/memcached --strip-components=1 \
	&& rm memcached.tar.gz \
	&& cd /usr/src/memcached \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	&& ./configure \
		--build="$gnuArch" \
		--enable-sasl \
		$enableExtstore \
	&& make -j "$(nproc)" \
# TODO https://github.com/memcached/memcached/issues/382 "t/chunked-extstore.t is flaky on arm32v6"
	&& make test \
	&& make install \
	\
	&& cd / && rm -rf /usr/src/memcached \
	\
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --virtual .memcached-rundeps $runDeps \
	&& apk del .build-deps \
	&& rm -fr /var/cache/apk/*

USER memcache
EXPOSE 11211
CMD ["memcached"]