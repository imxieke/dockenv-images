#!/usr/bin/env bash

PASSWORD=$(echo -n ${RANDOM} | md5sum | cut -b -16)
cpuNum=$(grep -c 'processor' < /proc/cpuinfo)

# Base language
printf "\n> Base language: \n"
select response in PHP Node; do
    if [ "$response" = "PHP" ]; then
        base="php"
        break
    elif [ "$response" = "Node" ]; then
        base="node"
        break
    else
        echo "Incorrect choice"
    fi
done

printf "\n> ${response} version ?\n"
# Configuration if PHP Base
if [ ${base} = "php" ]; then
    # PHP version
    select response in 7.4 7.3 7.2 7.1 7.0 5.6; do
        if [[ "$response" =~ ^(5.6|7.0|7.1|7.2|7.3|7.4)$ ]]; then
            version=${response}
            break
        else
            echo "Incorrect choice"
        fi
    done

    # PHP architecture
    printf "\n> FPM or Alpine [FPM] ?\n"
    select response in FPM Alpine; do
        if [[ "$response" =~ ^(FPM|Alpine)$ ]]; then
            archi=${response,,}
            break
        else
            echo "Incorrect choice"
        fi
    done

    # Web server
    printf "\n> Web server ?\n"
    select response in Nginx Apache; do
        if [[ "$response" =~ ^(Apache|Nginx)$ ]]; then
            webserver=${response,,}
            break
        else
            echo "Incorrect choice"
        fi
    done
fi

# Configuration if Node Base
if [ ${base} = "node" ]; then
    # Node version
    select response in 13.6 12.14 10.18; do
        if [[ "$response" =~ ^(13.6|12.14|10.18)$ ]]; then
            version=${response}
            break
        else
            echo "Incorrect choice"
        fi
    done
    # Node architecture
    printf "\n> Alpine version ?\n"
    select response in Yes No; do
        if [[ "$response" =~ ^(Yes|No)$ ]]; then
            if [ "$response" = "Yes" ]; then
                archi="-alpine"
            else
                archi=""
            fi
            break
        else
            echo "Incorrect choice"
        fi
    done
fi

# Common configuration

# Database
printf "\n> Database ?\n"
select response in MySQL MariaDB MongoDB None; do
    if [[ "$response" =~ ^(MySQL|MariaDB|MongoDB|None)$ ]]; then
        dbserver=${response,,}
        break
    else
        echo "Incorrect choice"
    fi
done

# Cache server
printf "\n> Cache server ?\n"
select response in Redis MemCached None; do
    if [[ "$response" =~ ^(Redis|MemCached|None)$ ]]; then
        cacheserver=${response,,}
        break
    else
        echo "Incorrect choice"
    fi
done

# Queuer server
printf "\n> Queuer server ?\n"
select response in RabbitMQ None; do
    if [[ "$response" =~ ^(RabbitMQ|None)$ ]]; then
        queuerserver=${response,,}
        break
    else
        echo "Incorrect choice"
    fi
done

# Maildev
printf "\n> Mail catcher ?\n"
select response in Maildev None; do
    if [[ "$response" =~ ^(Maildev|None)$ ]]; then
        mailcatcher=${response,,}
        break
    else
        echo "Incorrect choice"
    fi
done




    clear
  echo ' _         _   _      __  __      ____  '
  echo '| |       | \ | |    |  \/  |    |  _ \ '
  echo '| |       |  \| |    | |\/| |    | |_) |'
  echo '| |___    | |\  |    | |  | |    |  __/ '
  echo '|_____|   |_| \_|    |_|  |_|    |_|    '
  echo ''
  echo -e "For more details see \033[4mhttps://git.io/lnmp\033[0m"
  echo ''
