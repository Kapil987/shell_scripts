#!/bin/bash
###################################
#Purpose: To set up git
#Version: 1.0
#Owner:   kapil
#Input:   None
#Outpu:   None
####################################

## Git initialisation ## not required when already cloning
#echo " Initialsing git in current Directory"
#git init
#ls -la | grep .git
## if user has choosen to clone then this script is not required ##
#Checking root user or not ####

IROOT=`/usr/bin/whoami`
if [ ! "$IROOT" == "root" ] ; then
echo "you must be root"
exit
fi

#Checking whether if git is already installed ##
git --version &> /dev/null
if [ ! `echo "$?"` -eq "0" ] ; then
echo "git is not installed 1st run git_install.sh and then run this script"
exit
fi

#initialising git ##
echo " initilising git in new_repo"
git init
## Setting up Mandatory Parameter for Git ##
echo -e "Choose option \n 1)git config --global push.default matching \n 2)Or user git config --global push.default simple"
read NUM
case "$NUM" in
1)
        echo "option 1 selected"
        git config --global push.default matching
        ;;
2)
        echo "option 2 selected"
        git config --global push.default simple
;;
esac


## Setting up other Mandaroty Parameters for Git ##
echo -e "Enter your full name: "
read NAME
echo -e "Enter your email: "
read EMAIL
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global core.editor vi
git config --global color.ui true

## showing contents of git config to the user ##
git config --list 

## Heads up for developer ##
#USER=`whoami`
#sudo chown -R `whoami`:`whoami` `pwd` cant use whoami as it will always be root
echo "Enter alias name for git remote add"
read ALIAS
echo "Enter the URL of remote repo"
read URL
git remote add $ALIAS $URL
git remote -v
echo -e " \n Your Git has been successfully configured \n Your can now start developing code and pushing to the remote repositry"
