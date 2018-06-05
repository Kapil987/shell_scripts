#!/bin/bash
################################
#Purpose: To learn shell script file test
#Version: 1.0
#Owner 	: Kapil <kapil0123@gmail.com>
#Input	: None
#Output	: None
################################


if [-f "/etc/passwd"]; then
#true
echo "the file exist"
fi

if [-r "/etc/shadow"]; then
echo "you have read permission for shadow file"

else
echo "You do not have read permission"
fi 

echo "END"


