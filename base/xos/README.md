## Xiekers Tools Kit on Docker

ENV PAAS_ROOT password

### Software list:
```
Apache2 PHP7 Nodejs npm Python Ruby
zsh git vim curl screen pip nginx php  htop nmap sqlmap fping

```

### Run Docker instance

`docker run -d --name=xos -p 22:22 -p 80:80 -v /volume:/data -e PASS_ROOT=password imxieke/base:xos
