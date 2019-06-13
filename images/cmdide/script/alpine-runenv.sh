#!/usr/bin/env sh
set -e
description="Cmdide Run env Script"
ngx_cmd="/usr/sbin/nginx"
php_cmd="/usr/sbin/php-fpm7"
ngx_pid=$(ps -a | grep nginx | grep master | awk '{print $1}')
php_pid=$(ps -a | grep php | grep master | awk '{print $1}')

if [ $(id -u) -ne '0' ]; then
	echo " * Require Root User To Execute, Please"
	exit 1
fi

if [[ ! -z "$2"   ]]; then
	if [ "$2" != "nginx" ] && [ "$2" != "php" ] ; then
		echo "Service $2 not found"
		exit
	fi
fi

nginx_status()
{
	if [ ! -z $ngx_pid ]; then
		echo "* Status: Nginx is Running "
	else
		echo "* Status: Nginx Stopped"
	fi
}

nginx_start()
{
	if [[ -f "/sbin/start-stop-daemon" ]]; then
		/sbin/start-stop-daemon -x ${ngx_cmd}
		echo "* Status: Nginx is Running"
	else
		exec ${ngx_cmd}
		echo "* Status: Nginx is Running"
	fi
}

nginx_stop()
{
	if [ -z $ngx_pid ]; then
		echo "* Status: Nginx has Stopped"
	else
		kill $ngx_pid
		echo "* Status: Nginx Stopped Success"
	fi
}

nginx_reload()
{
	if [ -z $ngx_pid ]; then
		echo "* Status: Nginx has Stopped, Enable it to reload"
	else
		nginx -s reload
		echo "* Status: Nginx reload Success"
	fi
}

nginx_restart()
{
	if [ -z $ngx_pid ]; then
		echo "* Status: Nginx has Stopped, Enable it to reload"
	else
		kill $ngx_pid
		nginx_start
		echo "* Status: Nginx restart Success"
	fi
}

php_status()
{
	if [ ! -z $php_pid ]; then
		echo "* Status: PHP-FPM is Running "
	else
		echo "* Status: PHP-FPM Stopped"
	fi
}

php_start()
{
	if [[ -f "/sbin/start-stop-daemon" ]]; then
		/sbin/start-stop-daemon -x ${php_cmd}
		echo "* Status: Nginx is Running"
	else
		exec ${php_cmd}
		echo "* Status: Nginx is Running"
	fi
}

php_stop()
{
	if [ -z $php_pid ]; then
		echo "* Status: Nginx has Stopped"
	else
		kill $php_pid
		echo "* Status: Nginx Stopped Success"
	fi
}

php_reload()
{
	if [ -z $php_pid ]; then
		echo "* Status: Nginx has Stopped, Enable it to reload"
	else
		nginx -s reload
		echo "* Status: Nginx reload Success"
	fi
}

php_restart()
{
	if [ -z $php_pid ]; then
		echo "* Status: Nginx has Stopped, Enable it to reload"
	else
		kill $php_pid
		nginx_start
		echo "* Status: Nginx restart Success"
	fi
}

help()
{
	echo "Usage: [options] status | stop | start | restart | reload

Options:
  -s, status  --status                      set xtrace when running the script
  -k, start   --start                     show what would be done
  -x, stop    --stop                   only run commands when started
  -r, restart --restart                   only run commands when stopped
  -l, reload  --reload                      ignore dependencies
  -h, help    --help                        Display this help output
"
}

case $1 in
	status | -s | --status )
		${2}_status
		;;
	start | -k | --start )
		${2}_start
		;;
	stop | -x | --stop )
		${2}_stop
		;;
	restart | -r | --restart )
		${2}_restart
		;;
	reload | -l | --reload )
		${2}_reload
		;;
	help | -h | --help )
		help
		;;
	* )
	echo "* $1 Command error
 type help or -h to View help"
esac
