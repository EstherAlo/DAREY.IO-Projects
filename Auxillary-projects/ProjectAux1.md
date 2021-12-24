# SHELL SCRIPTING

In this project, I will onboard 20 new Linux users onto a server. Create a shell script that reads a csv file that contains the first name of the users to be onboarded.


I created a shell script and then created Onboard.sh file within my ubuntu server. The script was copied into this file.


Onboard.sh file was moved to a directory named 'Shell' and files id.rsa id.rsa.pub names.csv created 
![Pic2](./Images/Pic2.png)

id.rsa was populated with private key. id.rsa.pub populated with public key 


I then added 20 names to the names.csv file 

*Screenshot below*

![Pic3](./Images/Pic3.png)



                                                  
I executed the below command to create developers group

```
sudo groupadd developers
```


 to make the .sh file executable I ran this command
 
 ```
 sudo chmod +x Onboard.sh
 ```

I Switched to super user with command:

```
sudo su
```

*Screenshot below*

To run the script I entered this command: 

```
./Onboard.sh
```

I entered this command to confirm user have been created: ls -l /home/ 

                                                                
To confirm that the developers group was created I executed command: 

```
getent group developers:
```
                                                                
*Screen shot below*

![Pic4](./Images/Pic4.png)
