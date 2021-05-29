######################################################
#Purpose: Remote login, create a user, install packages
#Version: 1.0
#Owner  : Kapil <myemail@gmail.com>
#Input  : None
#Output : None
######################################################
#!/bin/bash

# The script assumes that you have created a user example ansible on master machine and want to create same user on remote server to build trust
# relationship (ssh without password) and then later manage with a configuration management tool such as ansible
# Your current directory should containe TestScript.sh server_list, ** (double star) are the points where you need to make changes

# Get the UserName to use while logging into a Remote machine
#echo "Enter the Remote UserName"
#read rmtuname

#echo "Enter the Remote Password"
#read -s rmtpasswrd


USERNAME=root # root login of remote server needs to be provided
rmtpasswrd=your_pass # root pass of remote server needs to be provided

# Read the ServerNames from server_list file
for server in `cat server_list` # should be in same directory
do
        # Printing the ServerName
        echo "Connecting to "$server

        # Write some Shell Script for Temporary Usage and Save in Current location
        cat << 'EOF' > ./TestScript.sh
                #!/bin/bash
                # Script for remote server
                # Once temporary username and password are setup then use configuration management tool to change the password
                temp_user=ansible  # this user will be for which you need to build the trust relationship **
                temp_pass=your_pass   # add temporary password for remote user **
                list_pack="tree vim-enhanced" # similary add more packages with space or use configuration management tool
                #echo "My Name is $0"
                #echo "I am Running on `hostname`"
                #echo "Installing tree package"


                ## Checking if package is installed
                install_check()
                {
                rpm -q $PACK
                if [ `echo $?` -eq 0 ]; then
                echo -e "$PACK is ALREADY installed!!! \n"
                else
                        echo "###########Installing $PACK ...#################"
                        yum -y install $PACK
                        echo -e "##########INSTALLATION FOR $PACK COMPLETED############# \n"
                fi
                }

                install_pack()
                {
                for PACK in $list_pack
                do
                        install_check $PACK
                done
                }
                install_pack # can be disabled if pack installation not required

                ## Check if USER already present
                echo -e "\nUser creation/validation process started\n"
                /usr/bin/id $temp_user
                if [ "$?" -eq 0 ]; then
                        echo -e "The user $temp_user is already present on the server!\n"
                        exit
                fi
                echo "Adding User on Remote Server:: $temp_user"
                useradd $temp_user
                echo $temp_pass | passwd --stdin $temp_user
  
                #echo "The Date on the Current System is `date`"
                #echo "That's all!!. I am Exitting"
                exit 0
EOF
        echo "Making script executable for remote server"
        chmod a+x TestScript.sh

        # SCP - copy the script file from Current Directory to Remote Server
        sshpass -p$rmtpasswrd scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no TestScript.sh $USERNAME@$server:/tmp/TestScript.sh

        # Take Rest for 5 Seconds
        sleep 5

        # SSH to remote Server  and Execute a Command [ Invoke the Script ]
        sshpass -p$rmtpasswrd ssh   -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $USERNAME@$server "/tmp/TestScript.sh"

        # ssh-copy-id, -o StrictHostKeyChecking=no is important here
        echo "**** Copying ssh keys ****"
        sshpass -p$temp_pass ssh-copy-id -o StrictHostKeyChecking=no $temp_user@$server

        #removing TestScript.sh from remote server
        echo "Removing Test Script from remote server"
        sshpass -p$rmtpasswrd ssh -o StrictHostKeyChecking=no $USERNAME@$server "rm /tmp/TestScript.sh"
done
