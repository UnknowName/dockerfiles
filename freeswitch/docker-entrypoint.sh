#!/bin/bash
export PATH
set -e

if [ $1 = "freeswitch" ];then
    if [ -z ${MYSQL_ADDR} ];then
        echo "not set MYSQL_ADDR, will use default file to stage FreeSWITCH core"
    else
        if [ ${MYSQL_DATABASE} ]; then
            if [ -z ${MYSQL_USER} ];then
                echo "Use default root for mysql user"
                MYSQL_USER="root"
            fi
            if [ -z ${MYSQL_PASSWORD} ];then
                echo "MySQL user ${MYSQL_USER} password not set!"
                exit 1
            fi
            # Create ODBC config file
        else
            MYSQL_DATABASE="freeswitch"
        fi
        echo "set MYSQL_ADDR, check user and passsword"
    fi
    /usr/local/freeswitch/bin/freeswitch
else
    exec "$@"
fi

# Create /etc/odbcini.conf
if [ ! -f "/etc/odbcinst.ini" ];then
cat > /etc/odbcinst.ini <<  EOF
[mysql]
Description=mysql
Driver=/usr/lib/x86_64-linux-gnu/odbc/libmyodbc.so
Setup=/usr/lib/x86_64-linux-gnu/odbc/libodbcmyS.so
FileUsage=1
EOF
fi

if [ ! -f "/etc/odbc.ini" ];then
cat > /etc/odbc.ini << EOF
[freeswitch]
Driver=mysql
Description=Mysql ODBC 2.3 DSN
Server=${MYSQL_ADDR}
Port=${MYSQL_PORT}
User=${MYSQL_USER}
Password=${MYSQL_PASSWORD}
Database=${MYSQL_DATABASE}
Option=3
Socket=
EOF
fi