#!/bin/bash
# To install and configure mariaDB

## Checking for root user
if [ `whoami` != "root" ] ; then
echo "You must be a root user"
exit
fi

## Creating mariaDB repo
if [ -f "/etc/yum.repos.d/MariaDB.repo" ] ; then
echo "MariaDB.repo already present in /etc/yum.repos.d/"
else
echo "Creating MariaDB.repo in /etc/yum.repos.d/"
cd /etc/yum.repos.d/
touch MariaDB.repo
echo "# MariaDB 10.3 CentOS repository list - created 2018-08-26 06:24 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.3/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
" > MariaDB.repo
fi

## Installing MariaDB
rpm -q MariaDB-server
if [ "$?" -eq "0" ] ; then
echo "MariaDB-server is already installed"
else
echo "Installing MariaDB-server..."
yum -y install MariaDB-server #MariaDB-client
fi

## Checking for mariadb.service
SERVICE=mariadb.service
systemctl status $SERVICE &> /dev/null
if [ "$?" -eq "0" ]; then
echo "$SERVICE is already RUNNING..."
else
COM=`systemctl start $SERVICE`
echo "####### STARTING $SERVICE  #######"
fi


## MariaDB secure installation provided bye mariaDB itself
sudo mysql_secure_installation # 

## Checking for mariadb.service at startup/bootup
CHK=`sudo systemctl status $SERVICE | awk '/disabled)/ {print $NF}'`

if [ "$CHK" != "disabled)" ]; then
echo "######### $SERVICE at is enabled at bootup#######"
else
echo -e "###### $SERVICE at bootup is disabled to enable it use \n sudo systemctl enable $SERVICE #######"
fi

echo -e "\n END OF SCRIPT"
