## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:6901/?password=vncpassword

## Unity 

`docker run -d --name="ubuntu" --hostname="ubuntu" -p 5901:5901 -p 6901:6901 registry.cn-hongkong.aliyuncs.com/imxieke/ubuntu:unity`

```
noVNC: 		ip:6901 
VNC: 		ip:5901
User: 		ubuntu
Pass: 		ubuntu
VNC Pass: 	ubuntu
```

### PS: if want to run Chrome , need add param `--privileged`
### Ubuntu Unity Desktop not work please wait a while or run ` docker restart container-id ` or `docker exec container-id unity > /tmp/unity.log & `
