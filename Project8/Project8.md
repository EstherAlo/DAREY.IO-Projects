##__Load balancer solution with Apache__


- In project 7, we had 3 Web Servers with each having its own public ip address.
- A client will have to access the site using different URLs , which is not a nice user experience. In order have a single point of access with a single public IP address/name, a Load Balancer can be used.
- A Load Balancer (LB) distributes clients’ requests among underlying Web Servers and makes sure that the load is distributed in an optimal way. 



![pic1](./images/pic1.png)

- The task of this project is to enhance out Tooling website solution by adding a Load Balancer to distribute traffic between Web Servers and allow users to access the website using a single URL.

The following resources were created in project 7:

1. Two RHEL8 Web Servers
1. One MySQL DB Server (based on Ubuntu 20.04)
1. One RHEL8 NFS server

*insert image*


## Configure Apache As A Load Balancer

- Spin up an ubuntu server 
- Open port 80 by creating an Inbound Rule in Security Group


- Install Apache Load Balancer and configure it to point traffic coming to LB to both Web Servers:

```
#Install apache2
sudo apt update
sudo apt install apache2 -y
sudo apt-get install libxml2-dev

#Enable following modules:
sudo a2enmod rewrite
sudo a2enmod proxy
sudo a2enmod proxy_balancer
sudo a2enmod proxy_http
sudo a2enmod headers
sudo a2enmod lbmethod_bytraffic

#Restart apache2 service
sudo systemctl restart apache2
```

- Ensure Apache2 is up and running 

```
sudo systemctl status apache2
```


- The Below configuraton was entered into/etc/apache2/sites-available/000-default.conf.

- The command below allows the apache server to map the ip addresses of the web server to this load balancer.


```
sudo vi /etc/apache2/sites-available/000-default.conf

<Proxy "balancer://mycluster">
               BalancerMember http://<WebServer1-Private-IP-Address>:80 loadfactor=5 timeout=1
               BalancerMember http://<WebServer2-Private-IP-Address>:80 loadfactor=5 timeout=1
               ProxySet lbmethod=bytraffic
               # ProxySet lbmethod=byrequests
        </Proxy>

        ProxyPreserveHost On
        ProxyPass / balancer://mycluster/
        ProxyPassReverse / balancer://mycluster/

```

*screenshot below*
![pic1](./images/pic2.png)


- Restart apache2 and confirm status 

```
sudo systemctl restart apache2, sudo systemctl status apache2.
```

- Verify that the configuration works by entering the LB public ip address into browser

- Unmount /var/log/httpd/ from the Web Servers to the NFS Server sudo umount -f /var/log/httpd and make sure the Web Server has its own log directory

- Opened two terminals for both Web Servers and run following command: 

```
sudo tail -f /var/log/httpd/access_log
```

- Refresh youe LB browser several times to make sure that both servers receive HTTP GET requests from the LB 

The number of requests to each server were approximately the same since I set loadfactor to the same value for both servers – this means that traffic will be disctributed evenly between them.

