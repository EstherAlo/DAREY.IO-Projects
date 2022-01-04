# __LOAD BALANCER SOLUTION WITH NGINX AND SSL/TLS__

During this project I will do the following:

1. Register a new domain name and connect to route 53
1. Configuring Nginx as a Load Balancer

## Register a new domain name and connect to route 53

I registered a www.esthertooling.co.uk on go daddy. I then went unto the route 53 dashboard on AWS and created a hosted zone, connected this to my domain. This will tell route 53 to respond to DNS queries for my domain.  


## Configure Nginx As A Load Balancer

In order to do this I completed the following:

1. Created an EC2 VM based on Ubuntu Server 20.04 LTS and opened TCP port 80 for HTTP connections and TCP port 443

1. Updated /etc/hosts file for local DNS with Web Servers’ names (e.g. Web1 and Web2) and their local IP addresses

1. Installed and configured Nginx as a load balancer to point traffic to the resolvable DNS names of the webservers

To update the server depositery and install nginx I executed this command:

```
sudo apt update && sudo apt install nginx
```

In order to Configure Nginx LB using Web Servers’ names defined in  /etc/hosts I created a config file by executing the below command:

sudo vi /etc/nginx/sites-available/load_balancer.conf  

The confisuration below was inserted and saved 

```
upstream web {
    server 35.178.103.192;
    server 3.10.232.111;
  }

server {
    listen 80;
    server_name esthertooling.co.uk www.esthertooling.co.uk;
    location / {
      proxy_pass http://myproject;
    }
  }

  ```

Removed default site so reverse proxy will be redirected to the new configuration file 

sudo rm -f /etc/nginx/sites-enabled/default

check the nginx has bee successfully confidured with this command: sudo nginx -t

linked load balanacer config file created in sites available to sites enabled so that nginx can access the configuration

/etc/nginx/sites-enabled 

sudo ln -s ../sites-available/load_balancer.conf . 