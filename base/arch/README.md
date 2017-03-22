# Archlinux Running in Docker

Usage :
	```
	docker run -d --name arch -e USERNAME=xxx -e ROOT_PASS=xxx -p 10022:22 -p 10080:80 -v /path:/path imxieke/arch:latest

	ROOT_PASS: Archlinux Container user password, 
	USERNAME : Archlinux Container username, 
	```