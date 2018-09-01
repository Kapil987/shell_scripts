#!/bin/bash
# Functions
ok() { echo -e '\e[32m'$1'\e[m'; } # To print output in Green , \e[m used for no color

EXPECTED_ARGS=2
E_BADARGS=65
MYSQL=`which mysql`

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 dbname dbuser "
  exit $E_BADARGS
fi

echo -n "Enter password for dbuser ";
stty -echo; # to hide password entered on console
read passwd;
stty echo;

Q1="CREATE DATABASE IF NOT EXISTS $1;"
Q2="GRANT ALL ON *.* TO '$2'@'localhost' IDENTIFIED BY '$passwd';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"

echo "When asked enter root password"
$MYSQL -uroot -p -e "$SQL"

ok "Database $1 and user $2 created with a password $passwd" # argument to ok function

