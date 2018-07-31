#!/usr/bin/expect -f
# ./scp_expect.sh /tmp/todev/ /tmp/ 192.168.0.41 kapil kapil
set source [lindex $argv 0]
set destination [lindex $argv 1]
set ip [lindex $argv 2]
set user [lindex $argv 3]
set password [lindex $argv 4]

if {$source ==""} {
puts "no source folder";
exit
}

if {$destination ==""} {
puts "no destination folder";
exit
}
if {$ip ==""} {
puts "no ip provided";
exit
}
if {$user ==""} {
puts "no user provided";
exit
}
if {$password ==""} {
puts "no password provided";
exit
}

spawn scp -r $source $user@$ip:$destination
expect "password:"
send "$password\r"
interact

