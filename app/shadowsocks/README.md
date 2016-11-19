## shadowsocks v2.8.2 for Docker
==================

This Dockerfile builds an image with the Python implementation of [shadowsocks](https://github.com/shadowsocks/shadowsocks). Based on Ubuntu 14.04 image.

### Quick Start
-----------

This image uses ENTRYPOINT to run the containers as an executable. 

    docker run -d -p 8388:8388 imxieke/shadowsocks -s 0.0.0.0 -p 8388 -k $SSPASSWORD -m aes-256-cfb

```
You can configure the service to run on a port of your choice.
Just make sure the port number given to Docker is the same as the one given to shadowsocks. 
Also, it is  highly recommended that you store the shadowsocks password in an environment variable as shown above. 
This way the password will not show in plain text when you run `docker ps`.
```

For more command line options, refer to the [shadowsocks documentation](https://github.com/shadowsocks/shadowsocks)