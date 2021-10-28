
##LEMP PROJECT

###INSTALLED THE NGINX WEB SERVER

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
