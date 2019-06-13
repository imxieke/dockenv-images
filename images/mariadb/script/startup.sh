#!/usr/bin/env bash

if [[  -z ${MYSQL_ROOT_PASSWORD} ]]; then
	MYSQL_ROOT_PASSWORD="root"
fi
# ch_sql_passwd
gen_chpasswd_sql()
{
	touch /tmp/chpasswd.sql
	cat > /tmp/chpasswd.sql <<EOF
UPDATE user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';
UPDATE mysql.user SET HOST='%' WHERE User='root' AND Host='127.0.0.1';
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES;
EOF
}

do_chpasswd()
{
	echo "=>Initializing database"
	mysql_install_db --user=mysql --basedir=/usr/ --datadir=/var/lib/mysql/ --rpm
	echo "=>Database initialized"

	echo "=>Set MYSQL Database Permission"
	chown -R mysql:mysql /var/lib/mysql
	chmod -R 755 /var/lib/mysql

	# echo "=>Start Mariadb Safe Mode"
	# mysqld_safe --skip-grant-tables &

	echo "=>Start mysql service"
	/etc/init.d/mysql start

	echo "Change MYSQL Password for root"
	cat /tmp/chpasswd.sql | mysql -uroot mysql
	# /usr/bin/mysqladmin -u root password "${MYSQL_ROOT_PASSWORD}"
	# echo "=>Excute SQL"
	# mysql -uroot mysql < /tmp/chpasswd.sql
	# echo "=>MYSQL root Password ${MYSQL_ROOT_PASSWORD}"

	# service mysql stop
	# echo "=>Stop mysql service"
	# /etc/init.d/mysql stop > /dev/null
	echo "
	=> MYSQL root Password ${MYSQL_ROOT_PASSWORD}
	" > /tmp/db.log
}

if [[ ! -d '/var/lib/mysql/mysql' ]]; then
	gen_chpasswd_sql
	do_chpasswd
else
	echo "=> Database Data Exist, Can't Set New Password"
fi

tail -f /tmp/db.log