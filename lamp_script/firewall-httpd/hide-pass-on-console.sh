#!/bin/bash
echo -n "USERNAME: ";
read uname
echo -n "PASSWORD: ";
stty -echo;
read passwd;
stty echo;
echo program $uname $passwd

