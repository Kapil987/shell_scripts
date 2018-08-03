#!/bin/bash
######################################
#Purpose: To learn shell script
#Version: 1.0
#Owner  : Kapil <kapil0123@gmail.com>
#Input  : Path/Filename , Static IP 
#Output : Static IP in Filename
######################################

SEARCH=dhcp                             
REPLACE=static                           
FILE_NAME=$1
					#/etc/sysconfig/network-scripts/ifcfg-enp0s3
if [ "$1" == "-help" ]; then
echo -e "This script is tested on CentOS. \nRoot access is required \nEnter config file as an 1st agrument \nexample: ./myscript.sh path/yourfilename \n"
exit
fi
## Checking whether root or not ##
IROOT=`/usr/bin/whoami`
if [ "$IROOT" != "root" ] ; then # == should be used for string comparison 
echo " You must be a root user "
exit
fi
## Taking File name form the user ##
if [ ! "$FILE_NAME" ]; then
echo "Enter filename as an 1st agrument example: ./myscript.sh your filename"
exit
fi
## Performing File Test ##
if [ -f "$FILE_NAME" ]; then
echo " You provided a valid Path/File name "
else
echo " Invalid File/Path "
exit
fi
## Check whether already static ip used ##
cat $FILE_NAME | grep -i static
if [ "$?" -eq "0" ]; then # &> /dev/null if you dont want to output on the console
echo "Your machine already have a Static IP"
exit
#else
#echo "Your Machine have dynamic IP"
fi

## Taking Static IP from the User ##
echo "Enter the static IP address: "
read static
## Creating Backup of file prior to editing ##
cp $FILE_NAME /home	                              #sed 's/\<apple\>/pineapple/' fruit
sed  -i "s/\<$SEARCH\>/$REPLACE/I" $FILE_NAME  #-i is used for change in file, I is used for case insensitive

echo "IPADDR=$static
NETMASK=255.255.255.0
GATEWAY=192.168.0.1
DNS1=8.8.8.8
DNS2=8.8.4.4
" >> $FILE_NAME 				# echo -e . -e tells echo to consider escape sequences as \n 
