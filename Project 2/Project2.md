
## LEMP PROJECT 



### INSTALLED THE NGINX WEB SERVER

Updated my server’s package index as it is the first time using apt: ```  
                                                                    sudo apt update
                                                                     ```
                                                     
                                    
Used apt command to install  Nginx:``` 
                                   sudo apt install nginx
                                   ```                                               
![P2A (2)](https://user-images.githubusercontent.com/93116204/139219823-c58a21a6-ed11-4c40-b271-fec20fc17e0e.png)


To verify that nginx was successfully installed and was running as a service in Ubuntu:``` 
                                                                                       sudo systemctl status nginx
                                                                                       ```
![P2A (3)](https://user-images.githubusercontent.com/93116204/139220994-be597f62-5f49-4aaf-9324-72b4a75200eb.png)

Opened TCP port 80 which is default port that web brousers use to access web pages in the Internet.
                                                
                                                
                                                
                                                    ```
Used ‘curl’ command to request our Nginx on port 80: curl -s http://169.254.169.254/latest/meta-data/public-ipv4                                                                                                                       ```

![Screen-28-10-2021_095132 (3)](https://user-images.githubusercontent.com/93116204/139404540-23fcebbd-1e8a-419d-baec-a1c1d5cad000.png)


### INSTALLING MYSQL

Now that my web server was up and running, I needed to install a Database Management System (DBMS) to be able to store and manage data for my site in a relational database. MySQL is a popular relational database management system used within PHP environments.

Used apt command to install  MySql:``` 
                                   sudo apt mysql-server
                                   ```         
 ![P2A (5)](https://user-images.githubusercontent.com/93116204/139405644-5b17265f-078c-40e0-956a-80f0b917936d.png)
 
Command to run a security script that comes pre-installed with MySQL:``` 
                                                                     sudo mysql_secure_installation
                                                                     ```

This script will remove some insecure default settings and lock down access to your database system.want I did not VALIDATE PASSWORD PLUGIN. Regardless of this the server asked me to select and confirm a password for the MySQL root user.
 
 ![P2B(1)](https://user-images.githubusercontent.com/93116204/139406258-7af14b2a-9dea-482c-a3c7-53759da3e28f.png)

 
                                  
