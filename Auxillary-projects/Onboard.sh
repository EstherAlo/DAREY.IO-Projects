# Shell Scripting. 
# This script will read a CSV file that contains 20 new Linux users
# This script will create each user on the server and add to an exisitng group called 'Developer'.
# This script will first check for the existence of the user on the system, before it will attempt to create 
# The user that is being created must also have a default home folder 
# Each user should have a .ssh folder within its HOME folder. If it does not exist, this it will be created.
# For each user's ssh configuration, we will create an authorized_keys file and add the below public key.

#!/bin/bash
userfile=$(cat names.csv)
PASSWORD=PASSWORD

# To ensure the user running this script has sudo priviledge 
   if [ $(id -u) -eq 0 ]; then 

# Reading the CSV file
        for user in $userfile;
        do
            echo $user 
        if id "$user" &>/dev/null
        then
            echo "User Exist"
        else            

# This will create a new user
        useradd -m -d /home/$user -s /bin/basg -g developers $user
        echo "New User Created"
        echo 


# This will create a ssh folder in the user home folder 
        su - -c "mkdir ~/.ssh"$user
        echo ".ssh directory created for new user"
        echo 

 # We need to set the user permission for the ssh dir 
          su = -c "chmod 700 ~/ .ssh" $user
          echo "user permission for .ssh directory set"   
          echo  

 # This will create an authorized key file            
         su - -c "touch ~/.ssh/" $user
         echo "Authorized key File Created"
         echo

# We need to set permission for the key file 
        su - -c "chmod 600 ~/.ssh/authorixed_keys" $user  
        echo "user permission for the Authorised key File set"
        echo

 # We need to create and set public key for users in the server 
         cp -R "/root/oboard/id_rse.pub" "home/$user/.ssh/authorized_keys"
         echo "Copied the Publuc key to New User Account on the server"
         echo
         echo

         echo "USER CREATED"

# Generate a password
sudo echo -e "$PASSWORD/n$PASSWORD"  sudo passwd "$user"
sudp passwd -x 5 $user   
            fi
        done
    else
    echo "Only Admin Can Onboard A user"
    fi 
                                