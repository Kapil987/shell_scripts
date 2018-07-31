#!/usr/bin/expect -f

#########Replace using SED###########
set fp [open ips]
while {-1 != [gets $fp line] } {
puts "\n ################\n# $line #\n#############\n"
spawn ssh $line "sed -i 's/192.168.0.225 centos_vm /192.168.0.225 work_vm /etc/hosts"
expect "password:"
send "kapil\r"
interact
}

