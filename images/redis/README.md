# Redis
> Redis is an open source key-value store that functions as a data structure server.

### start a redis instance

`$ docker run -d --name redis redis`

### start with persistent storage
`$ docker run --name some-redis -d redis redis-server --appendonly yes`
> If persistence is enabled, data is stored in the VOLUME /data, which can be used with --volumes-from some-volume-container or -v /docker/host/dir:/data (see docs.docker volumes).

> For more about Redis Persistence, see http://redis.io/topics/persistence.

### connecting via redis-cli
`$ docker run -it --network some-network --rm redis redis-cli -h some-redis`

Additionally, If you want to use your own redis.conf ...
You can create your own Dockerfile that adds a redis.conf from the context into /data/, like so.
```Dockerfile
FROM redis
COPY redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
```

Alternatively, you can specify something along the same lines with docker run options.

`$ docker run -v /myredis/conf:/usr/local/etc/redis --name myredis redis redis-server /usr/local/etc/redis/redis.conf`


> Where /myredis/conf/ is a local directory containing your redis.conf file. Using this method means that there is no need for you to have a Dockerfile for your redis container.

The mapped directory should be writable, as depending on the configuration and mode of operation, Redis may need to create additional configuration files or rewrite existing ones.
