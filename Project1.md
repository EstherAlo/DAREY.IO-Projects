
## LAMP PROJECT

Completed the following: 
* Creation of AWS account 
* Launched EC2 instance t2.micro family with Ubuntu Server 20.04 LTS (HVM)  
* Saved the private key
* Connected to the private key via GitBash terminal

###INSTALLED APACHE AND UPDATED THE FIREWALL

Installed Apache using Ubuntu's package manager by running command: ```
                                                                   sudo apt update 
                                                                    ```

Verified that apache2 was running as a Service in my OS: ```
                                                       sudo systemctl status apache2
                                                         ```

Apache2 status below 
![Project 1- C (2)](https://user-images.githubusercontent.com/93116204/138972237-0c769ceb-4afe-44ce-abfe-28d2e87b8560.png)

Requested my Apache HTTP server on port 80: ```
                                        curl http://localhost:80
                                            ```

Verified if my Apache HTTP server can respond to requests from the Internet. 

![defaultpage](https://user-images.githubusercontent.com/93116204/138972873-9a287524-61b1-4506-9e6e-58232be745c3.png)



###INSTALLED MYSQL

MYSQL is a popular relational database management system used within PHP enviroments

Installed MySQL by running this command: ```sudo apt install mysql-server
                                         ```

Ran a security script that comes pre-installed with MySQL: 

Prompted to set up password after running:  ```
                                           sudo mysql secure installation.
                                            ```

I logged into MySQL to test connection: ```
                                        sudo mysql
                                        ```
I then exited MySQL: ```
                     mysql> exit
                     ```
                     
                    ![Project1 - D (6)](https://user-images.githubusercontent.com/93116204/139133927-8a256a08-0d8d-49a8-a00c-e07982668f5a.png)
                    
                    
 
### INSTALLED PHP

PHP is the component of our setup that will process code to display dynamic content to the end user.

In addition to the php package, my server will need php-mysql, a PHP module that allows PHP to communicate with MySQL-based databases.

libapache2-mod-php will be required to enable Apache to handle PHP files. Core PHP packages will automatically be installed as dependencies.

These 3 packages were installed at once by running: ```
                                                    sudo apt install php libapache2-mod-php php-mysql
                                                    ```
                                                   
                                                    
 confirmed my PHP version by running: ```
                                      php -v
                                      ```
                                      
                                      
                                      
  ![Project1 - G (3)](https://user-images.githubusercontent.com/93116204/139135928-1216975b-7405-43d8-be96-29b392ab3404.png)

To test my setup with a PHP script, I set up a Apache Virtual Host to hold my website’s files and folders. 

The objective is to setup a domain called ‘projectlamp’.

Apache on Ubuntu 20.04 has one server block enabled by default that is configured to serve documents from the /var/www/html directory. 

I will add my own directory next next to the default one.

I created the directory for projectlamp using ‘mkdir’ command:``` 
                                                              sudo mkdir /var/www/projectlamp
                                                              ```
                                                              
 Assigned ownership of the directory with my current system user: ```      
                                                                  sudo chown -R $USER:$USER /var/www/projectlamp   
                                                                  ```
                                                                  
 Created and opened a new configuration file in Apache’s sites-available directory:``` 
                                                                                   sudo vi /etc/apache2/sites-available/projectlamp.conf
                                                                                   ```
This created a new blank file. I then pasted  in the following bare-bones configuration by hitting on i on the keyboard to enter the insert mode, and paste the text:

```
<VirtualHost *:80>
    ServerName projectlamp
    ServerAlias www.projectlamp 
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/projectlamp
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

Saved and closed the file, as shown below:

1. Hit the esc button on the keyboard

1. Type :

1. Type wq (w means write and q means quit)

1. Hit ENTER to save the file

The following command showed the new file in the sites-available directory: ```
                                                                            sudo ls /etc/apache2/sites-available
                                                                            ```

Screenshot below shows the new file in the site-available directory. With this VirtualHost configuration, we’re telling Apache to serve projectlamp using /var/www/projectlampl as its web root directory. 
![Project 1 - F (2)](https://user-images.githubusercontent.com/93116204/139141359-ff767a0c-969e-4e27-8f7b-59df825621f2.png)


I used the a2ensite command to enable the new virtual host:```
                                                           sudo a2ensite projectlamp
                                                           ```
                                                           
![Project1 - G (4)](https://user-images.githubusercontent.com/93116204/139143110-b8438846-7b52-45e0-a8f4-25716ad20dc7.png)

I disabled the default website that comes installed with Apache. This is required if you’re not using a custom domain name, because in this case Apache’s default configuration would overwrite my virtual host. 


Command to disable Apache’s default website:``` 
                                            sudo a2dissite 000-default
                                            ```

To make sure my configuration file doesn’t contain syntax errors i entered command:``` 
                                                                                   sudo apache2ctl configtest
                                                                                   ```
                                                                                   
I reloaded Apache so these changes take effect:``` 
                                               sudo systemctl reload apache2
                                               ```
                                               
![Project1 - G (5)](https://user-images.githubusercontent.com/93116204/139145212-6c4570d6-138f-4021-a878-a56e0fc59a17.png)
                                              

Created an index.html file in that location so that I could test that the virtual host works as expected:

```
sudo echo 'Hello LAMP from hostname' $(curl -s http://169.254.169.254/latest/meta-data/public-hostname) 'with public IP' $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4) > /var/www/projectlamp/index.html
```


### ENABLED PHP ON THE WEBSITE

With the default DirectoryIndex settings on Apache, a file named index.html will always take precedence over an index.php file. To change this behavior, I eddited the /etc/apache2/mods-enabled/dir.conf file and changed the order in which the index.php file was listed within the DirectoryIndex directive.

```
sudo vim /etc/apache2/mods-enabled/dir.conf
```

```
<IfModule mod_dir.c>
        #Change this:
        #DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm
        #To this:
        DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
```

I reloaded Apache so the changes take effect:``` 
                                             sudo systemctl reload apache2
                                             ```
                                             
 Created a PHP test script to confirm that Apache is able to handle and process requests for PHP files by opening a new file named index.php inside my custom web root folder:
 
 ``` 
vim /var/www/projectlamp/index.php
```       

I entered the text below inside the file, saved and closed:

```
<?php
phpinfo();
```

Refreshed my EC2 public ip address url page

![Project 1 (2)](https://user-images.githubusercontent.com/93116204/139148367-d847b8c7-f1be-43a1-b38b-d8cbc03ab1f7.png)

