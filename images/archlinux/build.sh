#!/usr/bin/env bash
DATE=$(date +%Y.%m.%d)
ROOTFS="/tmp/archlinux-rootfs/"
ROOTFSDIR=$(pwd)
FILENAME=archlinux-rootfs-${DATE}.tar
PKGS="pacman"

if [[ $(id -u) != 0 ]]; then
	echo "Not Permission,Using root user or sudo"
	exit 1
fi

base(){
	docker build
}

case $1 in
	build )
		echo "==>Install Base System to rootfs"
		mkdir -p ${ROOTFS}
		pacstrap -d -G -M ${ROOTFS} ${PKGS}
		pacman-key --init
		pacman-key --populate archlinux
		cd ${ROOTFSDIR}
		# tar --create --file=${FILENAME}.xz --xz --numeric-owner --acls --directory=${ROOTFSDIR} ${ROOTFS}
		tar --create --file=${FILENAME} --directory=${ROOTFS} .
		sha256sum ${FILENAME} > ${ROOTFSDIR}/${FILENAME}.sha256sum
		;;

	docker )
		docker build --no-cache -t imxieke/archlinux:base --file=Dockerfile.base .
		;;

	clear )
		echo "==>Clear Rootfs Environment"
		rm -fr ${ROOTFSDIR}/archlinux-rootfs-*
		rm -fr ${ROOTFS}
		echo "==> Clear Success"
		;;
	* )
		echo "Usage build [OPTION ... ]:
	build Build an archlinux rootfs
	clear Clear Rootfs Environment"
		;;

esac