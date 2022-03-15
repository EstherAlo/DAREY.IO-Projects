## __CLIENT-SERVER ARCHITECTURE PROJECT__

The task of the project is to implement a Client Server Architecture using MySQL Database Management System (DBMS)

Client-Server refers to an architecture in which two or more computers are connected together over a network to send and receive requests between one another.

In their communication, each machine has its own role: the machine sending requests is usually referred as "Client" and the machine responding (serving) is called "Server".

A machine that is trying to access a Web site using Web browser or simply ‘curl’ command is a client and it sends HTTP requests to a Web server (Apache, Nginx, IIS or any other) over the Internet.

If we extend this concept further and add a Database Server to our architecture, we can get this picture

![pic14](./images/pic14.png)


- Create and configure two linux-based virtual servers (EC2 instances in AWS) and connect. 

*screenshot below*

![Pic8](https://user-images.githubusercontent.com/93116204/156807418-a70feb62-6873-417c-abf0-b08d3d68f30e.png)

## Database Server

- On MYSQL server install MYSQL Server software: 

```
sudo apt update -y

sudo apt  install mysql-server -y
```

- Enable the service: 

```
sudo systemctl enable mysql
```

 *screenshot below*
 
![pic10](https://user-images.githubusercontent.com/93116204/156807588-b83fa9b6-a9c5-4be6-b16d-1b67b8db15aa.png)


- Update the inbound rules in MYSQL server, by adding TCP port 3306. For extra security allow access only to private IP address of MYSQL client..

*screenshot below*

![Pic9](https://user-images.githubusercontent.com/93116204/156807654-ba1831c4-35e2-450c-9fc0-9d8898e9f288.png)

- In MYSQL server, run the security script

```
sudo mysql_secure_installation
```

- Run mysql 

```
sudo mysql
```

- Create a remote user, database, grant all privileges on the database and flush privileges. See screenshot below

*screenshot below*

![pic11](https://user-images.githubusercontent.com/93116204/156807698-a1a5af29-79eb-411f-86c1-3eb1c8bc51e0.png)



- Configure MYSQL server to allow connections from remote hosts, replace ‘127.0.0.1’ to ‘0.0.0.0’ 
 
``` 
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
```
- Restart mysql

```
sudo systemctl restart mysql
```

## Client server

- On mysql server Linux Client I update the server and install MySQL Client with command: 

```
sudo apt update -y

sudo apt  install mysql-client -y
```

- From mysql client Linux Server connect remotely to mysql server Database Engine: 

```
sudo mysql -u remote_user -h <ip address> -p
```

- Confirm successfull connection to the remote MySQL server and perform SQL queries

```
Show databases;
```

* The screenshot below shows a fully functional MYSQL Client-Server set up*

 ![Pic12](https://user-images.githubusercontent.com/93116204/156807747-0d2a0b78-fa42-42fc-a1e5-87551ec6fb6e.png)

