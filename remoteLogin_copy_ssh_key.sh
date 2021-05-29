######################################################
#Purpose: Remote login, create a user, install packages
#Version: 1.0
#Owner  : Kapil <myemail@gmail.com>
#Input  : None
#Output : None
######################################################
#!/bin/bash

# Get the UserName to use while logging into a Remote machine
#echo "Enter the Remote UserName"
#read rmtuname

#echo "Enter the Remote Password"
#read -s rmtpasswrd

# once temporary username and password are setup then use configuration management tool to change the password
USERNAME=root
rmtpasswrd=tdc

temp_user=temp
temp_pass=tdc
# Read the ServerNames from Properties file
for server in `cat server_list`
do
        # Printing the ServerName
        echo "Connecting to "$server

        # Write some Shell Script for Temporary Usage and Save in Current location
        cat << 'EOF' > ./TestScript.sh
                #!/bin/bash
                temp_user=temp  # add temporary user here
                temp_pass=tdc   # add temporary password here
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

                ## check if user already present
                echo -e "\nUser creation/validation process started\n"
                /usr/bin/id $temp_user
                if [ "$?" -eq 0 ]; then
                        echo -e "The user $temp_user is already present on the server!\n"
                        exit
                fi
                echo "Adding User on Remote Server:: $temp_user"
                useradd $temp_user
                echo $temp_pass | passwd --stdin $temp_user
                #sshpass -p$rmtpasswrd ssh-copy-id $USERNAME@$server
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
