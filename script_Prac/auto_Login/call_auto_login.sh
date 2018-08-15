#!/bin/bash
# This script calls automate login script and provide user@ip to that script
# automate script can logins to the server on after the ssh adds those ips 
# into its know host file.
# When you run this for the 1st time it will just add those user@ip's to
# known host file. When your run for 2nd time it works as expected

## Taking ips from ips_file
for user in `cat ips_file`
do
.auto_login_expect.sh "$user" #sending each user@ip to auto_login_expect.sh
done
