#!/bin/bash

#Checking root user or not ####
IROOT=`/usr/bin/whoami`
if [ ! "$IROOT" == "root" ] ; then
echo "you must be root"
exit
fi

## checking whether if git is already installed ##
git --version &> /dev/null
if [ `echo "$?"` -eq "0" ] ; then
echo "git is already installed"
exit
else
echo "git is not installed"
fi

## installing git via install any soft script #
./install-any-soft 			# argument cannot be passed scripts ./install-any-soft $1

#Cloning project ##
echo -e "Press 1 to clone a repo \n Press 2 completly new setup of Git instructions "
read VAR
case $VAR in
1) 	echo "Enter the clone over HTTPS address of remote repository"
	read ADD
	git clone $ADD # as cd is not working we have to manually reach the cloned dir
	git remote -v
	git branch -a
	;;
2)	echo "Running git_setup.sh for initial setup of git"
	sudo ./git_setup.sh
	;;
esac

echo "## END OF SCRIPT ##"

