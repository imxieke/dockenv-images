#!/usr/bin/env bash
# Author: Cloudflying
# Desc:   Push to Docker Registry
# Mirros : https://22bvsrc3.mirror.aliyuncs.com
# docker login --username=xxx@aliyun.com registry.cn-hongkong.aliyuncs.com

IMG_DIR="`pwd`/images"

# Push to DaoCloud Registry
# PREFIX:="daocloud.io/imxieke"

# Push to Qiniu Cloud Registry
# PREFIX="reg.qiniu.com/imxieke"

action=$1
image=$2
tag=$3

if [[ $(curl -s https://api.ip.sb/geoip | grep Alibaba) != '' ]]; then
	PREFIX="registry-vpc.cn-hongkong.aliyuncs.com/imxieke"
elif [[ $(curl -s https://api.ip.sb/geoip | grep CN) != '' ]]; then
	PREFIX="registry.cn-hongkong.aliyuncs.com/imxieke"
elif [[ $(curl -s https://api.ip.sb/geoip | grep US) != '' ]]; then
	# Offcial Registry
	PREFIX="imxieke"
fi

function usage()
{
	echo "	Docker Build Tool
/-----------------------------------\\
|	build image name tag         |
|	push  image name tag         |
|	pull  image name tag         |
\\-----------------------------------/"
}

function build()
{
	if [[ ! -d "$IMG_DIR/$2" ]]; then
		echo "Catelog $2 or Dockerfile Not Exist"
		exit 1
	fi

	cd "$IMG_DIR/$2"
	if [[ $3 != '' ]]; then
		if [[ $3 == 'latest' ]]; then
			time docker $1 --no-cache -t ${PREFIX}/$2:latest .
		else
			time docker $1 --no-cache -t ${PREFIX}/$2:$3 --file=Dockerfile.$3 .
		fi
	else
		time docker $1 --no-cache -t ${PREFIX}/$2:latest .
	fi
}

function push()
{
	# echo $1 $2 $3 $4 $5 $6

	if [[ $3 != '' ]]; then
		if [[ $3 == 'latest' ]]; then
			time docker push ${PREFIX}/$2:latest
		else
			time docker push ${PREFIX}/$2:$3
		fi
	elif [[ $3 == '' ]]; then
		time docker push ${PREFIX}/$2:latest
	fi
}

function pull()
{
	if [[ $image != '' ]]; then
		if [[ $tag != '' ]]; then
			docker pull ${PREFIX}/$image:$tag
		else
			docker pull ${PREFIX}/$image:latest
		fi
	else
		usage
	fi
}

mariadb_all()
{
	echo ""
}

case $1 in
	build | -build | --build )
		build $1 $2 $3 $4 $5 $6
		;;

	push | -push | --push )
		push $1 $2 $3 $4 $5 $6
		;;

	pull | -pull | --pull )
		pull $1 $2 $3 $4 $5 $6
		;;
	-prefix | --prefix)
		echo ${PREFIX}
		;;
	help | -help | --help )
		usage
		;;
	* )
		usage
esac