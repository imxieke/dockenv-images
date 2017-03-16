ShadowsocksR Dockerfile
==================

This image uses ENTRYPOINT to run the containers as an executable. 

    docker run -d -p 8388:8388/tcp -p 8388:8388/udp daocloud/imxieke/ssr -s 0.0.0.0 -p 8388 -k password -m aes-256-cfb -o tls1.2_ticket_auth_compatible -O auth_sha1_v2_compatible


More Options
-----------

```
usage: ssserver [OPTION]...
A fast tunnel proxy that helps you bypass firewalls.

You can supply configurations via either config file or command line arguments.

Proxy options:
  -c CONFIG              path to config file
  -s SERVER_ADDR         server address, default: 0.0.0.0
  -p SERVER_PORT         server port, default: 8388
  -k PASSWORD            password
  -m METHOD              encryption method, default: aes-256-cfb
  -O PROTOCOL            protocol plugin, default: verify_simple
  -o OBFS                obfsplugin, default: http_simple
  -t TIMEOUT             timeout in seconds, default: 300
  --fast-open            use TCP_FASTOPEN, requires Linux 3.7+
  --workers WORKERS      number of workers, available on Unix/Linux
  --forbidden-ip IPLIST  comma seperated IP list forbidden to connect
  --manager-address ADDR optional server manager UDP address, see wiki

General options:
  -h, --help             show this help message and exit
  -d start/stop/restart  daemon mode
  --pid-file PID_FILE    pid file for daemon mode
  --log-file LOG_FILE    log file for daemon mode
  --user USER            username to run as
  -v, -vv                verbose mode
  -q, -qq                quiet mode, only show warnings/errors
  --version              show version information

```

[More help](https://github.com/breakwa11/shadowsocks-rss)
