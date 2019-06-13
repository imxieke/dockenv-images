### SSR
```
Usage:
docker run -d --name ssr -p 8388:8388/tcp -p 8388:8388/udp -e PASSWD=passwd -e PORT=8388 image:latest

```

## Config

config path:`/etc/shadowsocks.json`

```
{
"server":"0.0.0.0",
"server_ipv6": "[::]",
"local_address":"127.0.0.1",
"local_port":1080,
"port_password":{
    "8989":"password1",
    "8990":"password2",
    "8991":"password3"
},
"timeout":300,
"method":"aes-256-cfb",
"protocol": "origin",
"protocol_param": "",
"obfs": "plain",
"obfs_param": "",
"redirect": "",
"dns_ipv6": false,
"fast_open": false,
"workers": 1
}
```