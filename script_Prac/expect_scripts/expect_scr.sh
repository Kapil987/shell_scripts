#!/usr/bin/expect -f

spawn ./command.sh
expect "password: "
send "kapil\r"
expect "$ "
send "rpm -q tree\r"
expect "$ "
send "exit\r"

