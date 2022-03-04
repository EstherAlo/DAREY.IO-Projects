# CLIENT-SERVER ARCHITECTURE PROJECT

## Implement a Client Server Architecture using MySQL Database Management System (DBMS)

Two Linux-based virtual servers(EC2 instances in AWS) were created and configured  

*screenshot below*

![Pic8](https://user-images.githubusercontent.com/93116204/156807418-a70feb62-6873-417c-abf0-b08d3d68f30e.png)


### Database Server

On mysql server Linux Server I updated the repositries and installed MySQL Server software with command: 

```
sudo apt update -y

sudo apt  install mysql-server -y
```
I then enabled the service and then ran the security with the following command: 

```
sudo systemctl enable mysql
```
 *screenshot below*
 
![pic10](https://user-images.githubusercontent.com/93116204/156807588-b83fa9b6-a9c5-4be6-b16d-1b67b8db15aa.png)


MySQL server uses TCP port 3306 by default, so this was opened by creating a new entry in ‘Inbound rules’ in ‘mysql server’ Security Groups.

*screenshot below*

![Pic9](https://user-images.githubusercontent.com/93116204/156807654-ba1831c4-35e2-450c-9fc0-9d8898e9f288.png)


In the database server I created the user, database, granted and flushed privileges.

*screenshot below*

![pic11](https://user-images.githubusercontent.com/93116204/156807698-a1a5af29-79eb-411f-86c1-3eb1c8bc51e0.png)



To allow connections from remote hosts I  configured MySQL server  using the command below, I then Replaced ‘127.0.0.1’ to ‘0.0.0.0’ 
 
``` 
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
```



### Client server

On mysql server Linux Client I updated the server and installed MySQL Clinet with command: 

```
sudo apt update -y

sudo apt  install mysql-client -y
```

From mysql client Linux Server I connected remotely to mysql server Database Engine: 

sudo mysql -u remote_user -h <ip address> -p

I confirmed that I have successfully connected to a remote MySQL server and can perform SQL queries with the following comand: 

```
Show databases;
```

*sreenshot below*

 ![Pic12](https://user-images.githubusercontent.com/93116204/156807747-0d2a0b78-fa42-42fc-a1e5-87551ec6fb6e.png)

