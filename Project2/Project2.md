
# LEMP PROJECT 

LEMP is an open-source web application stack used to develop web applications. The term LEMP is an acronym that represents L for the Linux Operating system, Nginx (pronounced as engine-x, hence the E in the acronym) web server, M for MySQL database, and P for PHP scripting language


## INSTALL THE NGINX WEB SERVER

N stands for Nginx: It is a web server that follows an event-driven approach and handles multiple requests within one thread. Nginx supports all Unix-like OS and also supports windows partially. When a web browser requests a web page that request is handled by the web server, here that web server is Nginx. Then the webserver passes that request to server-side technologies used in the LEMP stack for instance as a server-side scripting language like PHP to communicate with server and database.
Updated my server’s package index as it is the first time using apt:

- Update the ubuntu repositries 

```
sudo apt update
```     
                                       
- install  Nginx:

```
sudo apt install nginx
```

                                             
![P2A (2)](https://user-images.githubusercontent.com/93116204/139219823-c58a21a6-ed11-4c40-b271-fec20fc17e0e.png)


Verify that nginx has  successfully installed:

```
sudo systemctl status nginx
```


![P2A (3)](https://user-images.githubusercontent.com/93116204/139220994-be597f62-5f49-4aaf-9324-72b4a75200eb.png)

- Opened TCP port 80 which is default port that web brousers use to access web pages in the Internet.
                                                
                                                                                      
- Use ‘curl’ command to request oNginx on port 80:

```
 curl -s http://169.254.169.254/latest/meta-data/public-ipv4                                                                                                                       ```
```

![Screen-28-10-2021_095132 (3)](https://user-images.githubusercontent.com/93116204/139404540-23fcebbd-1e8a-419d-baec-a1c1d5cad000.png)


## INSTALL MYSQL

M stands for MySQL: It is an open-source SQL-based database that is used to store data and manipulate data while maintaining data consistency and integrity. It organizes data in tabular form in rows and columns. It is also ACID-compliant. MySQL is a popular relational database management system used within PHP environments.

- Install  MySql: 

```                                
sudo apt mysql-server                                   
```     

 ![P2A (5)](https://user-images.githubusercontent.com/93116204/139405644-5b17265f-078c-40e0-956a-80f0b917936d.png)

- Run the security script - this comes pre-installed with mysql. This script removes some insecure default settings and locks down access to your database system. if you do not VALIDATE PASSWORD PLUGIN. The server will still ask for you to  select and confirm a password for the MySQL root user.

```
sudo mysql_secure_installation
``` 
 
 ![P2B(2)](https://user-images.githubusercontent.com/93116204/139408657-b6195770-fd53-4d9b-8771-b5d78ce99a9e.png)


- Log into my sql

```
sudo mysql    
```

```
mysql> exit
```                                                                                                   
                                  
![P2B(3)](https://user-images.githubusercontent.com/93116204/139410870-35d4a402-f33a-4bf5-8289-c60b101fdde8.png)

MySQL server is now installed and secured.


### INSTALL PHP

P stands for PHP: It stands for Hypertext Preprocessor and is a scripting language that works on the server-side and communicates with the database MySQL and does all operations which user requests like fetching data, adding data, or manipulating data, or processing the data. PHP processes code and generates dynamic content for the web server. Nginx requires an external program to handle PHP processing and act as a bridge between the PHP interpreter itself and the web server. 

* php-fpm, which stands for “PHP fastCGI process manager”, tell Nginx to pass PHP requests to this software for processing
* php-mysql, allows PHP to communicate with MySQL-based databases

Install php-fpm and php-mysql by running command:

``` 
sudo apt install php-fpm php-mysql
```

![P2C(1)](https://user-images.githubusercontent.com/93116204/139502119-041cde9d-86b2-41d9-940b-671092603962.png)

  
 ## Configure Nginx to Use PHP Processor

On Ubuntu 20.04, Nginx has one server block enabled by default and is configured to serve documents out of a directory at /var/www/html. While this works well for a single site, it can become difficult to manage if you are hosting multiple sites. Instead of modifying /var/www/html, we’ll create a directory structure within /var/www for the your_domain website, leaving /var/www/html in place as the default directory to be served if a client request does not match any other sites.

 
* I create the root web directory for your domain:

```
sudo mkdir /var/www/projectLEMP
```

* I assign ownership of the directory with the $USER environment variable:

```
sudo chown -R $USER:$USER /var/www/projectLEMP
```


* I opened a new configuration file in Nginx’s sites-available directory:

```
 sudo vi /etc/nginx/sites-available/projectLEMP
 ```
                                                                       
![P2C (2)](https://user-images.githubusercontent.com/93116204/139503892-11fb19f7-e99c-4e0b-8035-fb309211b588.png)


Paste in the following bare-bones configuration 

```

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
Activate the configuration by linking tconfig file to the Nginx’s sites-enabled directory. This will tell Nginx to use the configuration next time it is reloaded.

```
sudo ln -s /etc/nginx/sites-available/projectLEMP /etc/nginx/sites-enabled/
```


 Test the configuration for syntax errors:

```
 sudo nginx -t
 ```
 
![P2C (3)](https://user-images.githubusercontent.com/93116204/139505462-f5f7ebb1-75a8-48a5-ad0b-d1cd25c1cb3b.png)

Default Nginx host was disabled with command: 

```
sudo unlink /etc/nginx/sites-enabled/default
```

In order to apply the changes I reloaded Nginx using command:

```
sudo systemctl reload nginx]
```
                                                
                                                
In order to test that the new server block functions  create a  index.html file in /var/www/projectLEMP location:

```
sudo echo 'Hello LEMP from hostname' $(curl -s http://169.254.169.254/latest/meta-data/public-hostname) 'with public IP' $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4) > /var/www/projectLEMP/index.html
```

*Screenshot below*

![Screen-27-11-2021_075153](https://user-images.githubusercontent.com/93116204/143673216-e38f1170-4812-4aba-8eb5-b38ba08850fa.png)


## TEST PHP WITH NGINX

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
