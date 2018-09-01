#!/bin/bash
# Checking whether root or not
if [ `whoami` != "root" ]
then
echo "You must be a root user"
exit
fi

# Creating name for backup file
TIME=`date +%F` #CDATE=`date +%F`

# Ask user whether he want a full backup or individual backup
echo -e "For user: root \nPress 1 for full database backup \nPress 2 for individual database backup 
Press 3 for Full database backup restore (Atleast one database should exist in mysql to restore backup into it)
Press 4 for Individual database backup restore"
read INPUT
case "$INPUT" in
	1) echo "Enter full database backup file name this will be stored in current directory"
	read NAME 
	BNAME="$NAME-$TIME"
	mysqldump -u root -p --all-databases > $BNAME.sql 
	echo "Full database backup taken and stored as $BNAME.sql "
	ls -lrt
	;;
	2) echo "Enter the individual Database name"
	read NAME
	BNAME="$NAME-$TIME"
	mysqldump -u root -p $NAME > $BNAME.sql 
	echo "Full database backup taken and stored as $BNAME.sql "
	;;
	3) echo "Name of Existing Database in mysql in which this backup need to be restored"
	read NAME
	   echo "Enter the name/path of Database backup file"
	read FNAME
	mysql -u root -p $NAME < $FNAME
	;;
	#mysql -u [user] -p [database_name] < [file_name].sql
	4) echo "Name of Existing Database in mysql in which this backup need to be restored"
	read NAME
	   echo "Enter the name/path of Database backup file"
	read FNAME
	mysql -u root -p $NAME < $FNAME
	;;
	
esac

exit

		
