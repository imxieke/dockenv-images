# UNOfficial Kali Linux Docker
This Kali Linux Docker image provides a minimal base install of the latest version of the Kali Linux Rolling Distribution.
There are no tools added to this image, so you will need to install them yourself. 
For details about Kali Linux metapackages, check https://www.kali.org/news/kali-linux-metapackages/

ENV PAAS_ROOT password

### Software list:

```
zsh git vim curl screen pip nginx php  htop nmap fping
```
### Run a Docker instance:

`docker run -d --name=kali -p 22:22 -p 80:80  -e PASS_ROOT=password imxieke/base:kali`

#### Option:
```
-v /volume:/data
```

Mon Nov 21 22:09 UTC+8 2016 China
