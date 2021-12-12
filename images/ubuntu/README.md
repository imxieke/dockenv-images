## Connection ports for controlling the UI:
## VNC port:5901
## noVNC webport, connect via http://IP:6901/?password=vncpassword

## xfce4

* Ubuntu xfce4

`docker run -d -p 10022:22 -p 5901:5901 -p 6901:6901 registry.cn-hongkong.aliyuncs.com/boxs/boxs:xfce`

* Archlinux
* archlinux 需要添加 `-it` 指令 否则桌面无法正常运行
*
`docker run -d -it -p 10022:22 -p 5901:5901 -p 6901:6901 registry.cn-hongkong.aliyuncs.com/boxs/boxs:xfce-arch`

## Unity

`docker run -d --name="ubuntu" --hostname="ubuntu" -p 5901:5901 -p 6901:6901 registry.cn-hongkong.aliyuncs.com/imxieke/ubuntu:unity`

4.10 Warty Warthog
5.04 Hoary Hedgehog
5.10 Breezy Badger
6.06 LTS Dapper
6.10 Edgy Eft
7.04 Feisty Fawn
7.10 Gutsy Gibbon
8.04 LTS Hardy
8.10 Intrepid Ibex
9.04 Jaunty Jackalope
9.10 Karmic Koala
10.04 lucid	LTS Lucid
10.10 			Maverick Meerkat
11.04 			Natty Narwhal
11.10 			Oneiric Ocelot
12.04 			Precise Pangolin
12.10 			Quantal Quetzal
13.04 			Raring Ringtail
13.10 saucy		Saucy Salamander
14.04 trusty 	Trusty Tahr
14.10 utopic 	Utopic Unicorn
15.04 vivid 	Vivid Vervet
15.10 wily 		Wily Werewolf
16.04 xenial 	Xenial Xerus
16.10 yakkety	Yakkety Yak
17.04 zesty		Zesty Zapus
17.10 artful	Artful Aardvark
18.04 bionic 	Bionic Beaver
18.10 cosmic 	Cosmic Cuttlefish
19.04 disco 	Disco Dingo
19.10 eoan		Eoan Ermine
20.04 focal  	Focal Fossa
20.10 groovy 	Groovy Gorilla
21.04 hirsute Hirsute Hippo
21.10 impish Impish Indri
22.04 vjammy

```
noVNC: 		ip:6901
VNC: 		ip:5901
User: 		ubuntu
Pass: 		ubuntu
VNC Pass: 	ubuntu
```

### PS: if want to run Chrome , need add param `--privileged`
### Ubuntu Unity Desktop not work please wait a while or run ` docker restart container-id ` or `docker exec container-id unity > /tmp/unity.log & `
