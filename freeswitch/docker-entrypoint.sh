#!/bin/bash
export PATH
set -e

if [ $1 = "freeswitch" ];then
    if [ -z ${MYSQL_ADDR} ];then
        echo "not set MYSQL_ADDR env, will use default file to stage FreeSWITCH core"
    else
        if [ -z ${MYSQL_DATABASE} ];then
            echo "no set MYSQL_DATABSE env, use default name freeswitch"
            MYSQL_DATABASE="freeswitch"
        fi
        if [ -z ${MYSQL_PORT} ];then
            echo "no set MYSQL_PORT env,use default 3306"
            MYSQL_PORT="3306"
        fi
        if [ -z ${MYSQL_USER} ];then
            echo "no set MYSQL_USER env, use default root"
            MYSQL_USER="root"
        fi
        if [ -z ${MYSQL_PASSWORD} ];then
            echo "no set MYSQL_PASSWORD env, exit!"
            exit 1
        fi

        # Use ODBC MySQL
        echo "[mysql]" > /etc/odbcinst.ini
        echo "Description=mysql" >> /etc/odbcinst.ini
        echo "Driver=/usr/lib/x86_64-linux-gnu/odbc/libmyodbc.so" >> /etc/odbcinst.ini
        echo "Setup=/usr/lib/x86_64-linux-gnu/odbc/libodbcmyS.so" >> /etc/odbcinst.ini
        echo "FileUsage=1" >> /etc/odbcinst.ini

        echo "[freeswitch]" > /etc/odbc.ini
        echo "Driver=mysql" >> /etc/odbc.ini
        echo "Description=MySQL ODBC DSN" >> /etc/odbc.ini
        echo "Server=${MYSQL_ADDR}" >> /etc/odbc.ini
        echo "Port=${MYSQL_PORT}" >> /etc/odbc.ini
        echo "User=${MYSQL_USER}" >> /etc/odbc.ini
        echo "Password=${MYSQL_PASSWORD}" >> /etc/odbc.ini
        echo "Database=${MYSQL_DATABASE}" >> /etc/odbc.ini
        echo "Option=3" >> /etc/odbc.ini
        sed -i 's/<!--<param name="odbc-dsn" value="dsn:user:pass"\/>-->/<param name="odbc-dsn" value="freeswitch::"\/>/g' /etc/freeswitch/sip_profiles/internal.xml
    fi
    # /usr/local/freeswitch/bin/freeswitch
else
    # exec "$@"
fi
exec "$@"