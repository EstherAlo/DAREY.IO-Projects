# CLIENT-SERVER ARCHITECTURE PROJECT

## Implement a Client Server Architecture using MySQL Database Management System (DBMS)

Two Linux-based virtual servers(EC2 instances in AWS) were created and configured  

*screenshot below*

![Pic8](./images/Pic8.png)

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
![Pic10](./images/Pic10.png)

MySQL server uses TCP port 3306 by default, so this was opened by creating a new entry in ‘Inbound rules’ in ‘mysql server’ Security Groups.

*screenshot below*

![Pic9](./images/Pic9.png)

In the database server I created the user, database, granted and flushed privileges.

*screenshot below*

![Pic11](./images/Pic11.png)


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

To check that I have successfully connected to a remote MySQL server and can perform SQL queries i ran the following comand: 

```
Show databases;
```

*sreenshot below*

