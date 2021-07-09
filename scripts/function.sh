#!/usr/bin/env bash

## colors.sh ## a simple font colors include
##
e_error='\x1b[31;01m[error]:\x1b[0m';            # red
e_warn='\x1b[33;01m[warning]:\x1b[0m';           # yellow
e_success='\x1b[32;01m[success]:\x1b[0m';        # green
e_info='\x1b[30;01m[inform]:\x1b[0m';            # black
e_input='\x1b[34;01m[input required]:\x1b[0m';   # blue#!/bin/sh

# Swarm Size. (default is 3)
if [ -z "${SWARM_SIZE}" ]; then
    SWARM_SIZE=3
fi

# By default, 'virtualbox' will be used, you can set 'MACHINE_DRIVER' to override it.
if [ -z "${MACHINE_DRIVER}" ]; then
    export MACHINE_DRIVER=virtualbox
fi

# REGISTRY_MIRROR_OPTS="--engine-registry-mirror https://jxus37ac.mirror.aliyuncs.com"
INSECURE_OPTS="--engine-insecure-registry 192.168.99.0/24"
# STORAGE_OPTS="--engine-storage-driver overlay2"

MACHINE_OPTS="${STORAGE_OPTS} ${INSECURE_OPTS} ${REGISTRY_MIRROR_OPTS}"

# 将逗号替换为空格
# array=${value//,/ }

# 将字符串转为数组,数组元素会以字符串中的空格作为分割
# array=($value)

# 定义一个关联数组,关联数组可以用字符串作为键名,bash版本需要升级,mac默认为3.x,早已过时
declare -A env_config

# 读取配置文件到变量中
readEnvFile()
{
  # 获取文件内容,并将以"#"开头的行过滤掉
  env_content=($(grep -v '^#' .env | xargs))

  # 将.env配置文件内容读取到变量中
  for line in ${env_content[*]}; do
    cell=(${line//=/ })
    env_config[${cell[0]}]=${cell[1]}
  done
}

# 获取 env 内参数
get_env()
{
    grep NGINX_VERSION env.conf | awk -F '=' '{print $2}'
}

# show success message
showOk(){
  echo -e "\\033[34m[OK]\\033[0m $1"
}

# show error message
showError(){
  echo -e "\\033[31m[ERROR]\\033[0m $1"
}

# show notice message
showNotice(){
  echo -e "\\033[36m[NOTICE]\\033[0m $1"
}

check_env()
{
    # Root check
    [[ $(id -g) != '0' ]] && die 'Script must be run as root.'
}

gen_ssl()
{
    if [ ! -f /etc/nginx/ssl/default.crt ]; then
        openssl genrsa -out "/etc/nginx/ssl/default.key" 2048
        openssl req -new -key "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.csr" -subj "/CN=default/O=default/C=UK"
        openssl x509 -req -days 365 -in "/etc/nginx/ssl/default.csr" -signkey "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.crt"
    fi
}

gen_ssl2()
{
    # create self-signed server certificate:

    read -p "Enter your domain [www.example.com]: " DOMAIN

    echo "Create server key..."

    openssl genrsa -des3 -out $DOMAIN.key 1024

    echo "Create server certificate signing request..."

    SUBJECT="/C=US/ST=Mars/L=iTranswarp/O=iTranswarp/OU=iTranswarp/CN=$DOMAIN"

    openssl req -new -subj $SUBJECT -key $DOMAIN.key -out $DOMAIN.csr

    echo "Remove password..."

    mv $DOMAIN.key $DOMAIN.origin.key
    openssl rsa -in $DOMAIN.origin.key -out $DOMAIN.key

    echo "Sign SSL certificate..."

    openssl x509 -req -days 3650 -in $DOMAIN.csr -signkey $DOMAIN.key -out $DOMAIN.crt

    echo "Done!"
}

# prints colored text
print_style () {

    if [ "$2" == "info" ] ; then
        COLOR="96m"
    elif [ "$2" == "success" ] ; then
        COLOR="92m"
    elif [ "$2" == "warning" ] ; then
        COLOR="93m"
    elif [ "$2" == "danger" ] ; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    STARTCOLOR="\e[$COLOR"
    ENDCOLOR="\e[0m"

    printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

display_options () {
    printf "Available options:\n";
    print_style "   install" "info"; printf "\t\t Installs docker-sync gem on the host machine.\n"
    print_style "   up [services]" "success"; printf "\t Starts docker-sync and runs docker compose.\n"
    print_style "   down" "success"; printf "\t\t\t Stops containers and docker-sync.\n"
    print_style "   bash" "success"; printf "\t\t\t Opens bash on the workspace with user laradock.\n"
    print_style "   sync" "info"; printf "\t\t\t Manually triggers the synchronization of files.\n"
    print_style "   clean" "danger"; printf "\t\t Removes all files from docker-sync.\n"
}

# Stop all running containers for services not defined in the Compose file

stop_containers() {
    docker-compose down --remove-orphans
}

import_db()
{
    source colors.sh;
    ## selector-db.sh ## Select the db import files
    ##
    echo -e "e_input where is your backup file?";
    read ": " sql_import # the selected import
    # sql_import="~/Desktop/jeremy/Documents/backup.sql"; # manual override
    my_db_backup="import.sh-$(date | sed -e 's/ /_/g').sql"; # just in case =]
    echo "$e_info backing up existing db to: $CWD/$my_db_backup";
    read; # can always cmd-c out now
    mysqldump -u root -p --all-databases > $my_db_backup;
    echo "$e_info importing from $sql_import";
    read; # can always cmd-c out now
    mysql -u root -p -h < $sql_import;
}


## draw_menu() - a function to draw the menu
# based on: Draw-box.sh by Stefano Palmeri
# found here: http://tldp.org/LDP/abs/html/colorizing.html#DRAW-BOX
##
draw_menu()
{
    #=============#
    HORZ="~"
    VERT="|"
    CORNER_CHAR="o"
    E_SIZE="increase window size"
    R=2      # Row
    C=3      # Column
    H=10     # Height
    W=70     # Width
    col=1    # Color (red)
    BOX_HEIGHT=`expr $H - 1`   #  -1 correction needed because angle char "+"
    BOX_WIDTH=`expr $W - 1`    #+ is a part of both box height and width.
    T_ROWS=`tput lines`        #  Define current terminal dimension
    T_COLS=`tput cols`         #+ in rows and columns.

    #=============#
    # will it fit?
    if [ $R -lt 1 ] || [ $R -gt $T_ROWS ]||
        [ $C -lt 1 ] || [ $C -gt $T_COLS ]||
        [ `expr $R + $BOX_HEIGHT + 1` -gt $T_ROWS ]||
        [ `expr $C + $BOX_WIDTH + 1` -gt $T_COLS ]||
        [ $H -lt 1 ] || [ $W -lt 1 ]; then
    echo -e "$e_error $E_SIZE"; return 0;
    fi

    # Function within a function.
    plot_char(){
    echo -e "\x1b[${1};${2}H"$3
    }

    # Set title color, if defined.
    echo -ne "\x1b[3${col}m"
    # Draw vertical lines using plot_char function.
    count=1
    for (( r=$R; count<=$BOX_HEIGHT; r++)); do
        plot_char $r $C $VERT;
        case $count in
            1 ) echo -e "    ""\x1b[01m$s_title\x1b[0m"; ;;
            2 ) echo -e "    1)import-user-files.sh"; ;;
            3 ) echo -e "    2)lamp.sh"; ;;
            4 ) echo -e "    3)dev-tools.sh"; ;;
            5 ) echo -e "    4)gui-tools.sh"; ;;
            6 ) echo -e "    5)import-db.sh"; ;;
            8 ) echo -e "    *)quit"; ;;
        esac
        let count=count+1;
    done

    count=1
    c=`expr $C + $BOX_WIDTH`
    for (( r=$R; count<=$BOX_HEIGHT; r++)); do
    plot_char $r $c $VERT
    let count=count+1
    done

    #  Draw horizontal lines using plot_char function.
    count=1
    for (( c=$C; count<=$BOX_WIDTH; c++)); do
    plot_char $R $c $HORZ
    let count=count+1
    done

    count=1
    r=`expr $R + $BOX_HEIGHT`
    for (( c=$C; count<=$BOX_WIDTH; c++)); do
    plot_char $r $c $HORZ
    let count=count+1
    done

    # Draw box angles.
    plot_char $R $C $CORNER_CHAR
    plot_char $R `expr $C + $BOX_WIDTH` $CORNER_CHAR
    plot_char `expr $R + $BOX_HEIGHT` $C $CORNER_CHAR
    plot_char `expr $R + $BOX_HEIGHT` `expr $C + $BOX_WIDTH` $CORNER_CHAR
    #  Restore old colors.
    echo -ne "\x1b[0m"
    #  Put the prompt at bottom of the terminal.
    P_ROWS=`expr $T_ROWS - 2`
    echo -e "\x1b[${P_ROWS};1H"
}

backup_www()
{
    USERNAME=root #备份的用户名
    PASSWORD=$MYSQL_ROOT_PASSWORD  #备份的密码

    DATE=`date +%Y-%m-%d`  #用来做备份文件名字的一部分
    OLDDATE=`date +%Y-%m-%d -d '-10 days'`  #本地保存天数

    #创建备份的目录和文件
    DIR=/data/backup/db

    [ -d ${DIR} ] || mkdir -p ${DIR}
    [ -d ${DIR}/${DATE} ] || mkdir -p ${DIR}/${DATE}


    DBS=`mysql -u$USERNAME -p$PASSWORD -Bse "show databases"|grep -v "information_schema" |grep -v "test"`
    for db_name in $DBS
    do
        /usr/bin/mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" $db_name  > $DIR/$DATE/$db_name.sql
    done
    #/usr/bin/find $DIR -mtime +7  -name "data_[1-9]*" -exec rm -rf {} \;

    [ ! -d ${DIR}/${OLDDATE} ] || rm -rf ${DIR}/${OLDDATE} #保存10天 多余的删除最前边的
}

backup_mysql()
{
    USERNAME=root #备份的用户名
    PASSWORD=$MYSQL_ROOT_PASSWORD  #备份的密码

    DATE=`date +%Y-%m-%d`  #用来做备份文件名字的一部分
    OLDDATE=`date +%Y-%m-%d -d '-10 days'`  #本地保存天数

    #创建备份的目录和文件
    DIR=/data/backup/db

    [ -d ${DIR} ] || mkdir -p ${DIR}
    [ -d ${DIR}/${DATE} ] || mkdir -p ${DIR}/${DATE}


    DBS=`mysql -u$USERNAME -p$PASSWORD -Bse "show databases"|grep -v "information_schema" |grep -v "test"`
    for db_name in $DBS
    do
        /usr/bin/mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" $db_name  > $DIR/$DATE/$db_name.sql
    done
    #/usr/bin/find $DIR -mtime +7  -name "data_[1-9]*" -exec rm -rf {} \;

    [ ! -d ${DIR}/${OLDDATE} ] || rm -rf ${DIR}/${OLDDATE} #保存10天 多余的删除最前边的
}

restore_db()
{
    #路径
    #DIR=/var/lib/mysql/backup_mysql
    DIR=/data/backup/db
    #还原哪天的数据
    DATE=2019-03-15
    #还原数据库的名称
    db_name=mhehewan

    /usr/bin/mysql -uroot -p"$MYSQL_ROOT_PASSWORD" $db_name < $DIR/$DATE/$db_name.sql
}

# 给MySQL中用户授权,指定用户可远程访问
privilegeMysqlUsers()
{
  delay=10
  echo "等待Mysql服务启动，延时"$delay"s..."
  sleep "$delay"s

  # 在bash中不能加入-t参数,否则会报"the input device is not a TTY"
  # 在远程服务上执行的命令块,"remot_command"可自定义
  # 必须跟在 docker exec 命令行后面
  # msyql登陆命令需要写全参数,否则会因为默认的my.conf中bind_address=127.0.0.1
  docker exec -i lnmpr-mysql bash << remot_command
    mysql -hlocalhost -uroot -p${env_config[MYSQL_ROOT_PASSWORD]} --port=${env_config[MYSQL_PORT_DOCKER]}
    ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '${env_config[MYSQL_ROOT_PASSWORD]}';
    CREATE USER '${env_config[DB_USERNAME]}'@'%' IDENTIFIED BY '${env_config[DB_PASSWORD]}';
    CREATE USER '${env_config[DB_USERNAME]}'@'localhost' IDENTIFIED BY '${env_config[DB_PASSWORD]}';
    ALTER USER '${env_config[DB_USERNAME]}'@'%' IDENTIFIED WITH mysql_native_password BY '${env_config[DB_PASSWORD]}';
    ALTER USER '${env_config[DB_USERNAME]}'@'localhost' IDENTIFIED WITH mysql_native_password BY '${env_config[DB_PASSWORD]}';
    GRANT ALL PRIVILEGES ON *.* TO '${env_config[DB_USERNAME]}'@'%' WITH GRANT OPTION;
    GRANT ALL PRIVILEGES ON *.* TO '${env_config[DB_USERNAME]}'@'localhost' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    CREATE DATABASE ${env_config[DB_DATABASE]};
    exit
remot_command

  echo "MySQL用户授权完成。lnmpr服务容器已启动，您可以访问 http://localhost:${env_config[NGINX_PORT_LOCAL]} 查看"
}


backup_mysql_and_remove_old()
{
    # */1 * * * * /cron-shell/backup.sh
    DATE=`date +%Y-%m-%d`  #用来做备份文件名字的一部分
    OLDDATE=`date +%Y-%m-%d -d '-10 days'`  #本地保存天数

    #创建备份的目录和文件
    DIR=/data/backup/db

    [ -d ${DIR} ] || mkdir -p ${DIR}
    [ -d ${DIR}/${DATE} ] || mkdir -p ${DIR}/${DATE}


    DBS=`mysql -uroot -p$MYSQL_ROOT_PASSWORD -Bse "show databases"|grep -v "information_schema" |grep -v "test"`
    for db_name in $DBS
    do
        /usr/bin/mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" $db_name  > $DIR/$DATE/$db_name.sql
    done
    #/usr/bin/find $DIR -mtime +7  -name "data_[1-9]*" -exec rm -rf {} \;

    [ ! -d ${DIR}/${OLDDATE} ] || rm -rf ${DIR}/${OLDDATE} #保存10天 多余的删除最前边的
}


backup2()
{
    #保存备份个数，备份31天数据
    number=10

    #备份保存路径
    backup_dir=/home/data/backup_mysql/mhehewan

    #日期
    dd=`date +%Y-%m-%d-%H-%M-%S`

    #用户名
    username=root

    #密码
    password=Hengshi2019#@!123

    #将要备份的数据库
    database_name=mhehewan

    #如果文件夹不存在则创建
    if [ ! -d $backup_dir ];
    then
        mkdir -p $backup_dir;
    fi

    #备份
    mysqldump --add-locks --add-drop-table --hex-blob --allow-keywords --extended-insert=false -u${username} -p${password} ${database_name}  > ${backup_dir}/$database_name-$dd.sql

    #写创建备份日志
    echo "create $backup_dir/$database_name-$dd.dupm" >> $backup_dir/log.txt

    #找出需要删除的备份
    delfile=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | head -1`

    #判断现在的备份数量是否大于$number
    count=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | wc -l`

    if [ $count -gt $number ]
    then
    #删除最早生成的备份，只保留number数量的备份
    rm $delfile
    #写删除文件日志
    echo "delete $delfile" >> $backup_dir/log.txt
    fi
}
