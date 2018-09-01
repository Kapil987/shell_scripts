#!/bin/bash
# Functions
ok() { echo -e '\e[32m'$1'\e[m'; echo "$1"; } # To print output in Green , \e[m used for no color

EXPECTED_ARGS=3
E_BADARGS=65
MYSQL=`which mysql`

Q1="CREATE DATABASE IF NOT EXISTS $1;"
Q2="GRANT ALL ON *.* TO '$2'@'localhost' IDENTIFIED BY '$3';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 dbname dbuser dbpass"
  exit $E_BADARGS
fi

$MYSQL -uroot -p -e "$SQL"

ok "Database $1 and user $2 created with a password $3" # argument to ok function

