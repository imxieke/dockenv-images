## add user to docker group

### add user to `docker` group

`sudo usermod -aG ${USER} docker`

## docker compose 修改后不生效
> 重新创建容器即可

`docker-compose up -d servie`

## Linux Config Docker Mirrors
```bash
# macOS Docker
$ mkdir -p ~/.docker
# Linux Docker
$ sudo mkdir -p /etc/docker
$ sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://muehonsf.mirror.aliyuncs.com"]
}
EOF
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
```

## 学习文档
[Docker 配置详解](https://www.jianshu.com/p/2217cfed29d7)

[Docker 入门教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)

[Docker 微服务教程](http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html)
