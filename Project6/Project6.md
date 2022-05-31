## __Web Solution With WordPress__

The aim of this project is to prepare storage infrastructure on two Linux servers and implement a basic web solution using WordPress

## Three-tier Architecture

Generally, web, or mobile solutions are implemented based on what is called the Three-tier Architecture.

Three-tier Architecture is a client-server software architecture pattern that comprise of 3 separate layers

### Your 3-Tier Setup

1. A Laptop or PC to serve as a client
1. An EC2 Linux Server as a web server (This is where you will install WordPress)
3. An EC2 Linux server as a database (DB) server

Project 6 consists of two parts:

1. Configure storage subsystem for Web and Database servers based on Linux OS. 
1. Install WordPress (webserver) and connect it to a remote MySQL database server (database server).

## LAUNCH AN EC2 INSTANCE THAT WILL SERVE AS “WEB SERVER”

## Preparing a Web Server

- Launch an EC2 instance that will serve as "Web Server" and attach three volumes. 

Inspect what block devices are attached to the server

```
lsblk 
```

*screenshot below*

![Pic1a](https://user-images.githubusercontent.com/93116204/171228641-0f162966-9011-47f8-9afa-3e4bcbb9932a.png)


To see all mounts and free space on the server 

 df -h 

*Screenshot below*

![Pic1b](https://user-images.githubusercontent.com/93116204/171228707-47643dda-b9e6-4582-a0eb-bbb12230ae0f.png)


- Use gdisk utility to create a single partition on each of the 3 disks 

```
sudo gdisk /dev/xvdf /dev/xvdg /dev/xvdh
```

- view the newly configured partition on each of the 3 disks 

```
lsblk
```

*Screenshot below*

![pic4a](https://user-images.githubusercontent.com/93116204/171228900-d8556951-f417-42a7-b579-8dabaaba12af.png)


- Install lvm2 package

```
 sudo apt install lvm2
```

- Use the pvcreate utility to mark each of 3 disks as physical volumes 

```
sudo pvcreate /dev/xvdf1
sudo pvcreate /dev/xvdg1
sudo pvcreate /dev/xvdh1
```

*screenshot below*

![pic5a](https://user-images.githubusercontent.com/93116204/171229091-9dc45444-fe15-4cad-add9-89fcbc7bab0c.png)


- sudo pvs to confirm 

- Add all 3 PVs to a volume group:

```
sudo vgcreate webdata-vg /dev/xvdh1 /dev/xvdg1 /dev/xvdf1
```
                                                                
- Verify that the VG has been created successfully by running:

```
sudo vgs
```

*screenshot below*

![pic5b](https://user-images.githubusercontent.com/93116204/171229226-c61972ad-8046-4e8d-b6ea-f164bbfcf226.png)


Create  2 logical volumes. apps-lv, and logs-lv. apps-lv. This will be used to store data for the Website while, logs-lv will be used to store data for logs

```
sudo lvcreate -n apps-lv -L 14G webdata-vg
sudo lvcreate -n logs-lv -L 14G webdata-vg
```

Verify that the Logical Volume has been created successfully: 

```
sudo lvs
```

*screenshot below*

![pic5c](https://user-images.githubusercontent.com/93116204/171229466-5e3f1a42-f33d-4051-8a13-e7cc4124aa4d.png)


To confirm the whole set up I executed the following commands:

```
sudo vgdisplay -v #view complete setup - VG, PV, and LV

sudo lsblk 
```
*Screenshot below*

![pic6a](https://user-images.githubusercontent.com/93116204/171229509-53631ced-327f-46af-a640-bd1a66a6a495.png)



- Use mkfs.ext4 to format the logical volumes by executing the commands below: 

```
sudo mkfs -t ext4 /dev/webdata-vg/apps-lv
sudo mkfs -t ext4 /dev/webdata-vg/logs-lv
```

- Create a directory to store website files and mount this 

```
sudo mkdir -p /var/www/html

sudo mount /dev/webdata-vg/apps-lv /var/www/html/
```

- Create a directory to store backup log data 

```
sudo mkdir -p /home/recovery/logs
```

- Before mounting the file system back up all the files in the log directory /var/log into /home/recovery/logs by running this command:

```
sudo rsync -av /var/log/. /home/recovery/logs/
```

- Mount /var/log on logs-lv logical volume.

```
sudo mount /dev/webdata-vg/logs-lv /var/log
```

- Restor log files back into /var/log directory

```
sudo rsync -av /home/recovery/logs/. /var/log
```

### UPDATE THE `/ETC/FSTAB` FILE

Update the /etc/fstab file with the UUID, this ensures the mount configuration will persist after restart of the server. 

- Use the below command to retrieve this and then update the fstab file rememebering to remove the leading and ending quotes.

```
sudo blkid
```

*screenshot below*

![pic10a](https://user-images.githubusercontent.com/93116204/171229601-deac0ee3-dd21-47b9-9e8b-039c776c7d8d.png)



![fstaba](./images/fstaba.png)

- Test the configuration, if no error message displays then it implies it installations went smoothly.

```
 sudo mount -a
```

- Reload the daemon:

```
sudo systemctl daemon-reload
```
 
                            
- Verify the setup I ran command: 

```
df -h
```


### Preparing the Database Server

- Launch a second RedHat EC2 instance that will be the ‘DB Server’
- Repeat the same steps as the Web Server, but instead of apps-lv, create db-lv and mount it to /db directory instead of /var/www/html/


*Screenshot below*

![db-lvs](https://user-images.githubusercontent.com/93116204/171229919-b5116840-06b7-4e0c-87dc-d29a9c52795b.png)


![mount](https://user-images.githubusercontent.com/93116204/171229968-679ac7e4-df54-4834-a38e-9099e65dfef9.png)


## Install WordPress on your Web Server EC2

- Update the repository and install wget, Apache and it’s dependencies

```
sudo yum -y update

sudo yum -y install wget httpd php php-mysqlnd php-fpm php-json
```

- Start and enable Apache:

```
sudo systemctl enable httpd
sudo systemctl start httpd
```

- Install PHP and it’s depedencies: 

```
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install yum-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo yum module list php
sudo yum module reset php
sudo yum module enable php:remi-7.4
sudo yum install php php-opcache php-gd php-curl php-mysqlnd
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
setsebool -P httpd_execmem 1
```

- Restart Apache:

```
sudo systemctl restart httpd
```

- Download wordpress and copy wordpress to var/www/html:

```
  sudo mkdir wordpress
  cd wordpress
  sudo wget http://wordpress.org/latest.tar.gz
  sudo tar xzvf latest.tar.gz
  sudo rm -rf latest.tar.gz
  sudo cp wordpress/wp-config-sample.php wordpress/wp-config.php
```


cd into wordpress folders 

```
cd wordpress/
```

- Copy the content inside wordpress into /var/www/html/

```
sudo cp -R wordpress/. /var/www/html/
```


Configure SELinux Policies by running the following commands:

```
  sudo chown -R apache:apache /var/www/html/wordpress
  sudo chcon -t httpd_sys_rw_content_t /var/www/html/wordpress -R
  sudo setsebool -P httpd_can_network_connect=1
```

## Installing MySQL on your DB Server EC2

- Update  the repositories and install MySqlserver

```
sudo yum update
sudo yum install mysql-server
```

Restart, enabled MySql Verified that the service is up and running by using this command:

```
sudo systemctl restart mysqld
sudo systemctl enable mysqld
```

- Verify that the service is up and running by using this command:

```
sudo systemctl status mysqld
```

- Run the security script:

```
 sudo mysql_secure_installation 
```

## Configure DB to work with WordPress

I did the following:

- Created the database
- Created the user
- Created the password for te user
- Granted and flushed prvileges

*Screenshot below*

![createdatabase](https://user-images.githubusercontent.com/93116204/171230044-7581bbe8-6cb1-4917-9e9f-8a4268d91426.png)


## Configure WordPress to connect to remote database


To allow wordpress to connect to the database  open MySQL port 3306 on DB Server EC2. For extra security, only allowed access to the DB server only from the Web Server’s IP address, so in the Inbound Rule configuration specify source as /32


- Install MySQL client:

```
sudo yum install mysql
```

- connect from you Web Server to the DB server:

```
sudo mysql -u admin -p -h <DB-Server-Private-IP-address>
```

- Execute SHOW DATABASES; command and see a list of existing databases

*screenshot below*

![show](https://user-images.githubusercontent.com/93116204/171230089-41875cf9-03c9-4028-92ac-09a68567e0e5.png)


- Change permissions and configuration so Apache uses WordPress 

- Enabled TCP port 80 in Inbound Rules configuration for the Web Server EC2

- Access wordpress using the public ip adress:

*Screenshot below*

![Word1a](https://user-images.githubusercontent.com/93116204/171230167-f01eab79-c532-4462-a9d6-62f4b66c6cdf.png)


*Filled in my credentials*

![word2a](https://user-images.githubusercontent.com/93116204/171230195-453c02bb-7eeb-427d-b498-72fbf00b7619.png)


WordPress has successfully connected to youe remote MySQL database!

*Screenshot below*

![word3a](https://user-images.githubusercontent.com/93116204/171230226-077c7d10-9645-441d-8a50-80c4dbbdd6fa.png)


