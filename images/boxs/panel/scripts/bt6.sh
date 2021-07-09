#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8

startTime=`date +%s`

is64bit=`getconf LONG_BIT`

echo "
+----------------------------------------------------------------------
| Bt-WebPanel 6.x FOR Ubuntu/Debian
+----------------------------------------------------------------------
| Copyright © 2015-2099 BT-SOFT(http://www.bt.cn) All rights reserved.
+----------------------------------------------------------------------
| The WebPanel URL will be http://SERVER_IP:8888 when installed.
+----------------------------------------------------------------------
"
# ln -sf bash /bin/sh

DEPENDS="ruby lsb-release curl wget procps python python-pip python-dev python-imaging zip unzip openssl libssl-dev gcc libxml2 libxml2-dev libxslt zlib1g zlib1g-dev libjpeg-dev libpng-dev lsof libpcre3 libpcre3-dev cron"

function depends()
{
	echo "=> Start Upgrade Software Source:"
	apt update -y
	for depend in ${DEPENDS}; do
		apt install -y ${depend} # --force-yes
	done
}
depends

deepinSys=`cat /etc/issue`

if [ `whoami` != "root" ];then
	echo -e "\033[31mError: Please run the script with root privileges on Ubuntu, for example: sudo bash install.sh\033[0m";
	exit
fi

#自动选择下载节点
get_node_url(){
	nodes=(http://125.88.182.172:5880 http://103.224.251.67 http://128.1.164.196 http://download.bt.cn);
	i=1;
	if [ ! -f /bin/curl ];then
		if [ -f /usr/local/curl/bin/curl ];then
			ln -sf /usr/local/curl/bin/curl /bin/curl
		fi
	fi
	for node in ${nodes[@]};
	do
		start=`date +%s.%N`
		result=`curl -sS --connect-timeout 3 -m 60 $node/check.txt`
		if [ $result = 'True' ];then
			end=`date +%s.%N`
			start_s=`echo $start | cut -d '.' -f 1`
			start_ns=`echo $start | cut -d '.' -f 2`
			end_s=`echo $end | cut -d '.' -f 1`
			end_ns=`echo $end | cut -d '.' -f 2`
			time_micro=$(( (10#$end_s-10#$start_s)*1000000 + (10#$end_ns/1000 - 10#$start_ns/1000) ))
			time_ms=$(($time_micro/1000))
			values[$i]=$time_ms;
			urls[$time_ms]=$node
			i=$(($i+1))
		fi
	done
	j=5000
	for n in ${values[@]};
	do
		if [ $j -gt $n ];then
			j=$n
		fi
	done
	if [ $j = 5000 ];then
		NODE_URL='http://download.bt.cn';
	else
		NODE_URL=${urls[$j]}
	fi
	
}

echo '---------------------------------------------';
echo "Selected download node...";
get_node_url
download_Url=$NODE_URL
echo "Download node: $download_Url";
echo '---------------------------------------------';
setup_path=/www
port='8888'
if [ -f $setup_path/server/panel/data/port.pl ];then
	port=`cat $setup_path/server/panel/data/port.pl`
fi

#apt-get install ntp ntpdate -y
#/etc/init.d/ntp stop
#update-rc.d ntp remove
#cat >>~/.profile<<EOF
#TZ='Asia/Shanghai'; export TZ
#EOF
#rm -rf /etc/localtime
#cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#echo 'Synchronizing system time...'
#ntpdate 0.asia.pool.ntp.org
#apt-get upgrade -y

tmp=$(python -V 2>&1|awk '{print $2}')
pVersion=${tmp:0:3}

function config_pip()
{
	mkdir -p ~/.pip && touch ~/.pip/pip.conf
	echo "[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = https://pypi.tuna.tsinghua.edu.cn" > ~/.pip/pip.conf
}

config_pip

Install_pip()
{
	ispip=$(pip -V|grep python)
	if [ "$ispip" == '' ];then
		wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
		python get-pip.py
		rm -f get-pip.py
		ispip=$(pip -V|grep python)
		if [ "$ispip" == '' ];then
			apt install python-pip -y
		fi
	fi
}

# pip install setuptools
Install_setuptools()
{
	if [ ! -f "/usr/bin/easy_install" ];then
		wget -O setuptools-33.1.1.zip $download_Url/install/src/setuptools-33.1.1.zip -T 10
		unzip setuptools-33.1.1.zip
		rm -f setuptools-33.1.1.zip
		cd setuptools-33.1.1
		python setup.py install
		cd ..
		rm -rf setuptools-33.1.1
	fi
	
	if [ ! -f "/usr/bin/easy_install" ];then
		echo '=================================================';
		echo -e "\033[31msetuptools installation failed. \033[0m";
		exit;
	fi
}

Install_Pillow()
{
	isSetup=`python -m PIL 2>&1|grep package`
	if [ "$isSetup" = "" ];then
		wget -O Pillow-3.2.0.zip $download_Url/install/src/Pillow-3.2.0.zip -T 10
		unzip Pillow-3.2.0.zip
		rm -f Pillow-3.2.0.zip
		cd Pillow-3.2.0
		python setup.py install
		cd ..
		rm -rf Pillow-3.2.0
	fi
	isSetup=`python -m PIL 2>&1|grep package`
	if [ "$isSetup" = "" ];then
		echo '=================================================';
		echo -e "\033[31mPillow installation failed. \033[0m";
		exit;
	fi
}

Install_psutil()
{
	isSetup=`python -m psutil 2>&1|grep package`
	if [ "$isSetup" = "" ];then
		wget -O psutil-5.2.2.tar.gz $download_Url/install/src/psutil-5.2.2.tar.gz -T 10
		tar xvf psutil-5.2.2.tar.gz
		rm -f psutil-5.2.2.tar.gz
		cd psutil-5.2.2
		python setup.py install
		cd ..
		rm -rf psutil-5.2.2
	fi
	isSetup=`python -m psutil 2>&1|grep package`
	if [ "$isSetup" = "" ];then
		echo '=================================================';
		echo -e "\033[31mpsutil installation failed. \033[0m";
		exit;
	fi
}

Install_mysqldb()
{
	isSetup=`python -m MySQLdb 2>&1|grep package`
	if [ "$isSetup" = "" ];then
		wget -O MySQL-python-1.2.5.zip $download_Url/install/src/MySQL-python-1.2.5.zip -T 10
		unzip MySQL-python-1.2.5.zip
		rm -f MySQL-python-1.2.5.zip
		cd MySQL-python-1.2.5
		python setup.py install
		cd ..
		rm -rf MySQL-python-1.2.5
	fi
	
}

Install_chardet()
{
	isSetup=`python -m chardet 2>&1|grep package`
	if [ "$isSetup" = "" ];then
		wget -O chardet-2.3.0.tar.gz $download_Url/install/src/chardet-2.3.0.tar.gz -T 10
		tar xvf chardet-2.3.0.tar.gz
		rm -f chardet-2.3.0.tar.gz
		cd chardet-2.3.0
		python setup.py install
		cd ..
		rm -rf chardet-2.3.0
	fi
	isSetup=`python -m chardet 2>&1|grep package`
	if [ "$isSetup" = "" ];then
		echo '=================================================';
		echo -e "\033[31mchardet installation failed. \033[0m";
		exit;
	fi
}

Install_webpy()
{
	isSetup=`python -m web 2>&1|grep package`
	if [ "$isSetup" = "" ];then
		wget -O web.py-0.38.tar.gz $download_Url/install/src/web.py-0.38.tar.gz -T 10
		tar xvf web.py-0.38.tar.gz
		rm -f web.py-0.38.tar.gz
		cd web.py-0.38
		python setup.py install
		cd ..
		rm -rf web.py-0.38
	fi
	
	isSetup=`python -m web 2>&1|grep package`
	if [ "$isSetup" = "" ];then
		echo '=================================================';
		echo -e "\033[31mweb.py installation failed. \033[0m";
		exit;
	fi
}

pipArg=''
apt install libffi-dev -y
Install_pip

curl -Ss --connect-timeout 3 -m 60 http://download.bt.cn/install/pip_select.sh|bash
pip install --upgrade setuptools
pip install itsdangerous==0.24
pip install paramiko==2.0.2
pip install flask-socketio==3.0.2
pip install python-socketio==2.1.2
pip install Werkzeug==0.15.1
for p_name in psutil chardet virtualenv Flask Flask-Session Flask-SocketIO flask-sqlalchemy Pillow gunicorn gevent-websocket requests;
do
	pip install ${p_name}
done

is_gevent=$(pip list|grep gevent)

if [ "$is_gevent" = "" ];then
	if [ -f /usr/bin/yum ];then
		yum install python-gevent -y
	else
		apt install python-gevent -y
	fi
fi

pip install psutil chardet virtualenv Flask Flask-Session Flask-SocketIO flask-sqlalchemy Pillow gunicorn gevent-websocket paramiko
Install_Pillow
Install_psutil

pip install gunicorn
if [  -f /www/server/mysql/bin/mysql ]; then
	pip install mysql-python
	Install_mysqldb
fi
Install_chardet

mkdir -p $setup_path/server/panel/logs
mkdir -p $setup_path/server/panel/vhost/apache
mkdir -p $setup_path/server/panel/vhost/nginx
mkdir -p $setup_path/server/panel/vhost/rewrite
wget -O $setup_path/server/panel/certbot-auto $download_Url/install/certbot-auto.init -T 5
chmod +x $setup_path/server/panel/certbot-auto


if [ -f '/etc/init.d/bt' ];then
	/etc/init.d/bt stop
fi

mkdir -p /www/server
mkdir -p /www/wwwroot
mkdir -p /www/wwwlogs
mkdir -p /www/backup/database
mkdir -p /www/backup/site

wget -O panel.zip $download_Url/install/src/panel6.zip -T 10
wget -O /etc/init.d/bt $download_Url/install/src/bt6.init -T 10
if [ -f "$setup_path/server/panel/data/default.db" ];then
	if [ -d "/$setup_path/server/panel/old_data" ];then
		rm -rf $setup_path/server/panel/old_data
	fi
	mkdir -p $setup_path/server/panel/old_data
	mv -f $setup_path/server/panel/data/default.db $setup_path/server/panel/old_data/default.db
	mv -f $setup_path/server/panel/data/system.db $setup_path/server/panel/old_data/system.db
	mv -f $setup_path/server/panel/data/aliossAs.conf $setup_path/server/panel/old_data/aliossAs.conf
	mv -f $setup_path/server/panel/data/qiniuAs.conf $setup_path/server/panel/old_data/qiniuAs.conf
	mv -f $setup_path/server/panel/data/iplist.txt $setup_path/server/panel/old_data/iplist.txt
	mv -f $setup_path/server/panel/data/port.pl $setup_path/server/panel/old_data/port.pl
	mv -f $setup_path/server/panel/data/admin_path.pl $setup_path/server/panel/old_data/admin_path.pl
fi

unzip -o panel.zip -d $setup_path/server/ > /dev/null

if [ -d "$setup_path/server/panel/old_data" ];then
	mv -f $setup_path/server/panel/old_data/default.db $setup_path/server/panel/data/default.db
	mv -f $setup_path/server/panel/old_data/system.db $setup_path/server/panel/data/system.db
	mv -f $setup_path/server/panel/old_data/aliossAs.conf $setup_path/server/panel/data/aliossAs.conf
	mv -f $setup_path/server/panel/old_data/qiniuAs.conf $setup_path/server/panel/data/qiniuAs.conf
	mv -f $setup_path/server/panel/old_data/iplist.txt $setup_path/server/panel/data/iplist.txt
	mv -f $setup_path/server/panel/old_data/port.pl $setup_path/server/panel/data/port.pl
	mv -f $setup_path/server/panel/old_data/admin_path.pl $setup_path/server/panel/data/admin_path.pl
	
	if [ -d "/$setup_path/server/panel/old_data" ];then
		rm -rf $setup_path/server/panel/old_data
	fi
fi

rm -f panel.zip

if [ ! -f $setup_path/server/panel/tools.py ];then
	echo -e "\033[31mERROR: Failed to download, please try again!\033[0m";
	echo '============================================'
	exit;
fi

rm -f $setup_path/server/panel/class/*.pyc
rm -f $setup_path/server/panel/*.pyc
python -m compileall $setup_path/server/panel
#rm -f $setup_path/server/panel/class/*.py
#rm -f $setup_path/server/panel/*.py

chmod 777 /tmp
chmod +x /etc/init.d/bt
ln -sf /etc/init.d/bt /usr/bin/bt
update-rc.d bt defaults
chmod -R 600 $setup_path/server/panel
chmod +x $setup_path/server/panel/certbot-auto
chmod -R +x $setup_path/server/panel/script
echo "$port" > $setup_path/server/panel/data/port.pl
/etc/init.d/bt start
password=`cat /dev/urandom | head -n 16 | md5sum | head -c 8`
sleep 1
admin_auth='/www/server/panel/data/admin_path.pl'
if [ ! -f $admin_auth ];then
	auth_path=`cat /dev/urandom | head -n 16 | md5sum | head -c 8`
	echo "/$auth_path" > $admin_auth
fi
auth_path=`cat $admin_auth`
cd $setup_path/server/panel/
python -m py_compile tools.py
python tools.py username
username=`python tools.pyc panel $password`
cd ~
echo "$password" > $setup_path/server/panel/default.pl
chmod 600 $setup_path/server/panel/default.pl
/etc/init.d/bt restart
sleep 1
isStart=`ps aux |grep 'gunicorn'|grep -v grep|awk '{print $2}'`
if [ "$isStart" == '' ];then
	echo -e "\033[31mERROR: The BT-Panel service startup failed.\033[0m";
	echo '============================================'
	exit;
fi

if [ ! -f "/usr/bin/ufw" ];then
	apt-get install -y ufw
fi

if [ -f "/usr/sbin/ufw" ];then
	ufw allow 888,20,21,22,80,$port/tcp
	ufw allow 39000:40000/tcp
	ufw_status=`ufw status`
	echo y|ufw enable
	ufw default deny
	ufw reload
fi

pip install psutil chardet psutil virtualenv $pipArg
if [ ! -d '/etc/letsencrypt' ];then
	mkdir -p /etc/letsencrypt
	mkdir -p /var/spool/cron
	if [ ! -f '/var/spool/cron/crontabs/root' ];then
		echo '' > /var/spool/cron/crontabs/root
		chmod 600 /var/spool/cron/crontabs/root
	fi
fi

wget -O acme_install.sh $download_Url/install/acme_install.sh
nohup bash acme_install.sh &> /dev/null &
sleep 1
rm -f acme_install.sh

if [[ "${deepinSys}" =~ eepin ]]; then
	address="localhost"
else
	address=`curl -sS --connect-timeout 10 -m 60 https://www.bt.cn/Api/getIpAddress`
	
	if [ "$address" == '0.0.0.0' ] || [ "$address" == '' ];then
		isHosts=`cat /etc/hosts|grep 'www.bt.cn'`
		if [ "$isHosts" == '' ];then
			echo "" >> /etc/hosts
			echo "125.88.182.170 www.bt.cn" >> /etc/hosts
			address=`curl -sS --connect-timeout 10 -m 60 https://www.bt.cn/Api/getIpAddress`
			if [ "$address" == '' ];then
				sed -i "/bt.cn/d" /etc/hosts
			fi
		fi
	fi
	
	ipCheck=`python -c "import re; print(re.match('^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$','$address'))"`
	if [ "$address" == "None" ];then
		address="SERVER_IP"
	fi
	if [ "$address" != "SERVER_IP" ];then
		echo "$address" > $setup_path/server/panel/data/iplist.txt
	fi
fi

curl -sS --connect-timeout 10 -m 60 https://www.bt.cn/Api/SetupCount?type=Linux\&o=$1 > /dev/null 2>&1
if [ "$1" != "" ];then
	echo $1 > /www/server/panel/data/o.pl
	cd /www/server/panel
	python tools.py o
fi

echo -e "=================================================================="
echo -e "\033[32mCongratulations! Install succeeded!\033[0m"
echo -e "=================================================================="
echo -e "Bt-Panel: http://$address:$port$auth_path"
echo -e "username: $username"
echo -e "password: $password"
echo -e "\033[33mWarning:\033[0m"
echo -e "\033[33mIf you cannot access the panel, \033[0m"
echo -e "\033[33mrelease the following port (8888|888|80|443|20|21) in the security group\033[0m"
echo -e "=================================================================="
rm -fr /www/server/panel/data/admin_path.pl

endTime=`date +%s`
((outTime=($endTime-$startTime)/60))
echo -e "Time consumed:\033[32m $outTime \033[0mMinute!"
