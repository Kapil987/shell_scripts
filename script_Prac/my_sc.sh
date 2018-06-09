#!/bin/bash
################################
#Purpose: To learn shell script file test
#Version: 1.0
#Owner 	: Kapil <kapil0123@gmail.com>
#Input	: None
#Output	: None
################################

echo "Please enter the dir"
read MYDIR

if [ $MYDIR==0 ]; then
echo "please enter the dir"
exit

if [ -f "$MYDIR" ]; then
#true
echo "the file exist"

if [ -r "$MYDIR" ]; then
echo "you have read permission for shadow file"

else
echo "You do not have read permission"
fi 

if [ ! "$MYDIR" ]; then
echo "dir $MYDIR exists"
else
echo "Dir $MYDIR does not exists"
fi

echo "END"


