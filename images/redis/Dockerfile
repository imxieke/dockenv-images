FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

ENV REDIS_VERSION=5.0.1 \
	REDIS_DOWNLOAD_URL=https://qcloud.coding.net/u/imxieke/p/Collect/git/raw/master/src/redis-5.0.1.tar.gz \
	REDIS_DOWNLOAD_SHA=82a67c0eec97f9ad379384c30ec391b269e17a3e4596393c808f02db7595abcb

# for redis-sentinel see: http://redis.io/topics/sentinel
# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -S redis && adduser -S -G redis redis ; \
	apk add --no-cache tzdata ; \
	apk add --no-cache --virtual .build-deps coreutils gcc jemalloc-dev linux-headers make musl-dev ; \
	wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL"; \
	echo "$REDIS_DOWNLOAD_SHA *redis.tar.gz" | sha256sum -c -; \
	mkdir -p /usr/src/redis; \
	tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1; \
	rm redis.tar.gz; \
	# disable Redis protected mode [1] as it is unnecessary in context of Docker
	# (ports are not automatically exposed when running inside Docker, but rather explicitly by specifying -p / -P)
	# [1]: https://github.com/antirez/redis/commit/edd4d555df57dc84265fdfb4ef59a4678832f6da
	grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h; \
	sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h; \
	grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h; \
	# for future reference, we modify this directly in the source instead of just supplying a default configuration flag because apparently "if you specify any argument to redis-server, [it assumes] you are going to specify everything"
	# see also https://github.com/docker-library/redis/issues/4#issuecomment-50780840
	# (more exactly, this makes sure the default behavior of "save on SIGTERM" stays functional by default)
	make -C /usr/src/redis -j "$(nproc)"; \
	make -C /usr/src/redis install; \
	rm -r /usr/src/redis; \
	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --virtual .redis-rundeps $runDeps; \
	apk del .build-deps; \
	mkdir /data && chown -R redis:redis /data ; \
	rm -fr /var/cache/apk/*

USER redis
VOLUME /data
WORKDIR /data

EXPOSE 6379
CMD ["redis-server"]