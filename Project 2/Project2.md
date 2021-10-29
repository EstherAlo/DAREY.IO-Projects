
## LEMP PROJECT 



### INSTALLING THE NGINX WEB SERVER

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
 
I ran this command which installs a security script that comes pre-installed with MySQL:``` 
                                                                                         sudo mysql_secure_installation
                                                                                         ```

This script removed some insecure default settings and locked down access to my database system. I did not VALIDATE PASSWORD PLUGIN. Regardless of this the server asked me to select and confirm a password for the MySQL root user.
 
 ![P2B(2)](https://user-images.githubusercontent.com/93116204/139408657-b6195770-fd53-4d9b-8771-b5d78ce99a9e.png)


I ran the following commands to test if could log into the MySQL console and also exited MySql:
```
sudo mysql    
```

```
mysql> exit
```                                                                                                   
                                  
![P2B(3)](https://user-images.githubusercontent.com/93116204/139410870-35d4a402-f33a-4bf5-8289-c60b101fdde8.png)

MySQL server is now installed and secured.


### INSTALLING PHP

PHP processes code and generates dynamic content for the web server. Nginx requires an external program to handle PHP processing and act as a bridge between the PHP interpreter itself and the web server. 

* php-fpm, which stands for “PHP fastCGI process manager”, and tell Nginx to pass PHP requests to this software for processing
* php-mysql, allows PHP to communicate with MySQL-based databases

 I installed php-fpm and php-mysql by running command:``` 
                                                      sudo apt install php-fpm php-mysql
                                                      ```
![P2C(1)](https://user-images.githubusercontent.com/93116204/139502119-041cde9d-86b2-41d9-940b-671092603962.png)

  
 ### Configuring Nginx to Use PHP Processor
 
* I created the root web directory for my domain by running:``` 
                                                           sudo mkdir /var/www/projectLEMP
                                                           ```
                                                           
* I assign ownership of the directory with the $USER environment variable:``` 
                                                                        sudo chown -R $USER:$USER /var/www/projectLEMP
                                                                        ```
                                                                        
* I opened a new configuration file in Nginx’s sites-available directory:```
                                                                       sudo nano /etc/nginx/sites-available/projectLEMP
                                                                       ```
                                                                       
![P2C (2)](https://user-images.githubusercontent.com/93116204/139503892-11fb19f7-e99c-4e0b-8035-fb309211b588.png)


This created a new blank file. I then Pasted in the following bare-bones configuration and closed using 'CTRL+X':
```
#/etc/nginx/sites-available/projectLEMP

server {
    listen 80;
    server_name projectLEMP www.projectLEMP;
    root /var/www/projectLEMP;

    index index.html index.htm index.php;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
     }

    location ~ /\.ht {
        deny all;
    }

}
                                                                       
```

Activated my configuration by linking to the config file from Nginx’s sites-enabled directory:``` 
                                                                                             sudo ln -s /etc/nginx/sites-available/projectLEMP /etc/nginx/sites-enabled/
                                                                                             ```
* This will tell Nginx to use the configuration next time it is reloaded. 

 Tested my configuration for syntax errors by typing:```
                                                     sudo nginx -t
                                                     ```
![P2C (3)](https://user-images.githubusercontent.com/93116204/139505462-f5f7ebb1-75a8-48a5-ad0b-d1cd25c1cb3b.png)


Default Nginx host was disabled with command: ``` 
                                             sudo unlink /etc/nginx/sites-enabled/default
                                             ```


In order to apply the changes I reloaded Nginx using command:``` 
                                                             sudo systemctl reload nginx]
                                                             ```
                                                
                                                
In order to test that my new server block functions  I created a  index.html file in /var/www/projectLEMP location:

```
sudo echo 'Hello LEMP from hostname' $(curl -s http://169.254.169.254/latest/meta-data/public-hostname) 'with public IP' $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4) > /var/www/projectLEMP/index.html
```
