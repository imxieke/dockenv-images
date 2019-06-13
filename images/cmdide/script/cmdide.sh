#!/us/bin/env bash
FILE="/tmp/cmdide.status"
DAEMON=/bin/nginx
NAME=cmdide
DESC=cmdide

function is_root(){
	if [[ `id -u ` != 0 ]]; then
		echo \
"\$:~ $0: Error Tips:                                         
  Permission Denied, Please Using Root User or 'sudo' 			  
  Current User: `whoami` "
exit
	fi
}

is_root

case $1 in
	status )
		cat ${FILE}
		;;

	start )
		service nginx start
		service php7.3-fpm start
		service php7.2-fpm start
		service php7.1-fpm start
		service php7.0-fpm start
		echo "Cmdide is Running" > ${FILE}
		;;

	stop )
		service nginx stop
		service php7.3-fpm stop
		service php7.2-fpm stop
		service php7.1-fpm stop
		service php7.0-fpm stop
		echo "Cmdide is Stop" > ${FILE}
		;;

	reload )
		service nginx reload
		service php7.3-fpm reload
		service php7.2-fpm reload
		service php7.1-fpm reload
		service php7.0-fpm reload
		echo "Cmdide is Running" > ${FILE}
		;;

	reload )
		service nginx restart
		service php7.3-fpm restart
		service php7.2-fpm restart
		service php7.1-fpm restart
		service php7.0-fpm restart
		echo "Cmdide is Running" > ${FILE}
		;;

	* )
		echo "Usage: $NAME {start|stop|restart|reload|force-reload|status|configtest|rotate|upgrade}"
		;;
esac