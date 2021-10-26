
## LAMP PROJECT

Completed the following: 
* Creation of AWS account 
* Launched EC2 instance t2.micro family with Ubuntu Server 20.04 LTS (HVM)  
* Saved the private key
* Connected to the private key via GitBash terminal

INSTALLED APACHE AND UPDATED THE FIREWALL

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



## INSTALLED MYSQL

MYSQL is a popular relational database management system used within PHP enviroments

Installed MySQL by running this command: 

Ran a security script that comes pre-installed with MySQL: 

Prompted to set up password after running:  ```
                                           sudo mysql secure installation.
                                            ```
I logged into MySQL to test connection: 


Exited MySQL
