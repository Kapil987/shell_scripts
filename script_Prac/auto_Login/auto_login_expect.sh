#!/usr/bin/expect
# This auto login script is called by call_auto_login script.
# This script helps in auto login and perform various tasks
# required for the automation

#set password "[exec passwd]"
#DIR=`cat passwd`
## Taking command line arguments
set host [lindex $argv 0]
set pass "nottrue" # set your passwd here
eval spawn ssh -oStrictHostKeyChecking=no -oCheckHostIP=no "$host"
#use correct prompt
set prompt ":|#|\\\$"
interact -o -nobuffer -re $prompt return
send "$pass\r"
interact -o -nobuffer -re $prompt return
send "rpm -q tree\r"
interact -o -nobuffer -re $prompt return
send "ls -l\r"
interact -o -nobuffer -re $prompt return
send "exit\r"
interact

