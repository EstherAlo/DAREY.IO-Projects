
# LEMP PROJECT 



## INSTALLING THE NGINX WEB SERVER

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


## INSTALLING MYSQL

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

  
 ## Configuring Nginx to Use PHP Processor
 
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

*Screeenshot below*

![Screen-27-11-2021_075153](https://user-images.githubusercontent.com/93116204/143673216-e38f1170-4812-4aba-8eb5-b38ba08850fa.png)


## TESTING PHP WITH NGINX

At this point, the LAMP stack is completely installed and fully operational.

To valiate that it can correctly hand Nginx .php files off to your PHP processor I created a test PHP file in the document root by opening a new file called info.ophp

```
sudo nano /var/www/projectLEMP/info.php
```

Entered a valid PHP code that will return information about the server:

```
<?php
phpinfo();
```

Accessed this page in the web browser by visiting the public IP address, followed by info.php


![Screen-27-11-2021_080928](https://user-images.githubusercontent.com/93116204/143673967-442a47b2-1ffe-482f-ab06-69b8f2e6974e.png)


                                                                                                               
Removed the file created as it contains sensitive information about the PHP environment and the Ubuntu server with command below: 

```
sudo rm /var/www/your_domain/info.php
```
                                                                                                                  
## Retrieving data from MySQL database with PHP

During this process I created a test database (DB) with simple "To do list" and configure access to it, so the Nginx website would be able to query data from the DB and display it.
                                              ```
I connected to MySql using the root account:  sudo mysql
                                              ``
                                                                                     
In order to create a new database, I run the following command from MsSql console:

```
CREATE DATABASE `example_database`;
```
                                                                                   
                                                                                   
                                                                                                                                 
To give this user permission over the example_database database I ran this commad and then exited:

```
GRANT ALL ON example_database.* TO 'example_user'@'%';
```                                                                                                   
                                                                                                                                           
To to test if  the new user has the proper permissions I logged into the MySQL console again, this time using the custom user credentials:

```
-u example_user -p
```                                                                                                                                           

*Screenshot below*

![2a](https://user-images.githubusercontent.com/93116204/144015251-869ea381-4e5c-452d-b520-f5839f59584d.png)

                                                                                 
To confirm that I have access to the example_database database I entered command:

```
SHOW DATABASES;
```                                                                                 

*Screenshot below*

![2b](https://user-images.githubusercontent.com/93116204/144015734-502c3018-f126-43a1-b7f1-9f46ef2d24ac.png)


A test table named todo_list was created From the MySQL console with statement:

```
CREATE TABLE example_database.todo_list (item_id INT AUTO_INCREMENT,
content VARCHAR(255),PRIMARY KEY(item_id));
```

Inserted a few rows of content in the test table

*Screenshot below*

                                                                                  
To confirm that the data was successfully saved to the table, I run this command:

```
SELECT * FROM example_database.todo_list;
```                                                                                  

![2e](https://user-images.githubusercontent.com/93116204/144017269-dcd93a4b-cf1f-4461-9fcc-2ce20fcc7ceb.png)


A PHP script that will connect to MySQL and query for my content was made. 
                                                                                      
                                                                                       
To create a new PHP file in the custom web root directory I run the following command: 

```
nano /var/www/projectLEMP/todo_list.php
```

The script below was entered into todo_list.php:

```
<?php
$user = "example_user";
$password = "password";
$database = "example_database";
$table = "todo_list";

try {
  $db = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
  echo "<h2>TODO</h2><ol>";
  foreach($db->query("SELECT content FROM $table") as $row) {
    echo "<li>" . $row['content'] . "</li>";
  }
  echo "</ol>";
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
```      
The page was accessed in my web browser by visiting the public IP address!

![2f](https://user-images.githubusercontent.com/93116204/144018828-c4b6de55-056e-4bc1-bd1d-07ad289ee1a4.png)
