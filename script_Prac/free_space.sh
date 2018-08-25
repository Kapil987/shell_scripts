#!/bin/bash
# This script is for free up space from
# given dir. You can decide how much old (days)
# packges/files are to be removed. if you wish to
# empty dir you will have that option too.

## Checking whether root user or not
if [ `whoami` != "root" ] ; then
echo "You must be a root user"
exit
fi

## Enter the DIR
DIR=/tmp/

## Checking for space in DIR
SIZE=`sudo du -s /tmp/ | awk '{print $1}'`		#o/p 60940k in kb
VALUE=10
if [ "$SIZE" -ge "$VALUE" ] ; then
echo -e "The $DIR is filled with greater than $VALUE K \n"
echo "Removing 5 days old packages from $DIR"
find $DIR* -mtime +5 -exec rm {} \;
echo "Size of $DIR after cleanup" 
du -s $DIR
else
echo "The $DIR is filled less than $VALUE K"
fi
## sudo find /tmp -type d -empty -delete to delete empty DIR's 
echo "## End of script ##"

