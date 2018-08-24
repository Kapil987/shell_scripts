#!/bin/bash
# This scritp needs to be run after httpd is installed

## Checking for httpd is installed or not
httpd -v &> /dev/null
if [ ! "$?" -eq "0" ] ; then
echo " 1st Use firewall-httpd-install script to install httpd then run this script"
exit
fi

## Installing PHP
php --version &> /dev/null
if [ ! "$?" -eq "0" ] ; then
echo " php is not installed so installing php"
sudo yum -y install php
fi

## Creating PHP test page
echo "Created test page for PHP"
cd /var/www/html
touch dynamic.php
echo -e "<?php 
echo \""This is test php page"\";
date_default_timezone_set('Asia/Calcutta');
echo \" "Today is "\" . date(\""Y.m.d"\");
echo \"" The time is "\" . date(\""h:i:sa"\");
?>" > dynamic.php

## Installing phpMyAdmin
rpm -q phpMyAdmin &> /dev/null

if [ ! "$?" -eq "0" ]; then
echo "Installing phpMyAdmin.."
sudo yum install -y phpMyAdmin
fi
echo "Enter you windows ip (ipconfig)"
read WIP

echo "Allowing windows ip in /etc/httpd/conf.d/phpMyAdmin.conf"
echo " ## The below line are not the part of actual phpMyAdmin.conf ##
<Directory /usr/share/phpMyAdmin/>
   AddDefaultCharset UTF-8

   <IfModule mod_authz_core.c>
     # Apache 2.4
     <RequireAny>
	Require ip 127.0.0.1
	Require ip $WIP
       Require ip ::1
     </RequireAny>
   </IfModule>
   <IfModule !mod_authz_core.c>
     # Apache 2.2
     Order Deny,Allow
     Deny from All
     Allow from 127.0.0.1
     Allow from ::1
   </IfModule>
</Directory>
" >> /etc/httpd/conf.d/phpMyAdmin.conf
echo "Restarting httpd.service"
systemctl stop httpd.service
sleep 1
systemctl start httpd.service
sleep 1
echo "### END OF SCRIPT ###"
