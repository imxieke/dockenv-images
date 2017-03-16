## Xiekers Tools Kit on Docker

ENV PAAS_ROOT password

### Software list:
```
zsh git vim curl screen pip nginx php  htop nmap fping

```

### Run Docker instance

`docker run -d --name=xtk -p 22:22 -p 80:80 -v /volume:/data -e PASS_ROOT=password imxieke/base:xtk`
