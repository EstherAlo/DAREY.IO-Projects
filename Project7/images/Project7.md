# __DEVOPS TOOLING WEBSITE SOLUTION__

In this project I will implement a solution that consists of following components:

1. Infrastructure: AWS
1. Webserver Linux: Red Hat Enterprise Linux 8
1. Database Server: Ubuntu 20.04 + MySQL
1. Storage Server: Red Hat Enterprise Linux 8 + NFS Server
1. Programming Language: PHP
1. Code Repository: GitHub


# PREPARE NFS SERVER

Launched an EC2 instance with RHEL that will serve as "Web Server" and attached three volumes. To inspect what block devices are attached to the server I Used the this command: lsblk 


*screenshot below*


To see all mounts and free space on the server I used the following command: 

 df -h 

*Screenshot below*

I used gdisk utility to create a single partition on each of the 3 disks and then to view the newly configured partition on each of the 3 disks the lsblk command: 

*Screenshot below*



I ran the following command to install lvm2: sudo yum install lvm2

Used pvcreate utility to mark each of 3 disks as physical volumes (PVs) to be used by LVM and verified that the physical volumes has been created successfully

```
sudo pvcreate /dev/xvdf1
sudo pvcreate /dev/xvdg1
sudo pvcreate /dev/xvdh1
```

*screenshot below*



To add all 3 PVs to a volume group (VG) I run the following command:

```
sudo vgcreate webdata-vg /dev/xvdh1 /dev/xvdg1 /dev/xvdf1
```
                                                                
Verification that the VG has been created successfully by running:

```
sudo vgs
```

*screenshot below*



I created 3 logical volumes. apps-lv, and logs-lv. apps-lv will be used to store data for the Website while, logs-lv will be used to store data for logs

```
sudo lvcreate -n apps-lv -L 9G webdata-vg
sudo lvcreate -n logs-lv -L 9G webdata-vg
sudo lvcreate -n opt-lv -L 9G webdata-vg
```

I verfied that the Logical Volume had been created successfully by running: 

```
sudo lvs
```

*screenshot below*



To confirm the whole set up I ran the following commands:

```
sudo vgdisplay -v #view complete setup - VG, PV, and LV

sudo lsblk 
```
*Screenshot below*


I used mkfs.xfs to format the logical volumes with xfs filesystem with the commands below: 

```
sudo xfs -t /dev/webdata-vg/apps-lv
sudo xfs -t /dev/webdata-vg/logs-lv
sudo xfs -t /dev/webdata-vg/opt-lv
```

Created mount points on /mnt directory for the logical volumes:

*Screenshot below*

To install, configure the NFS to start on reboot and confirm that it is running I ran the commands below:

```
sudo yum -y update
sudo yum install nfs-utils -y
sudo systemctl start nfs-server.service
sudo systemctl enable nfs-server.service
sudo systemctl status nfs-server.service
```

Permission was updated to allow our Web servers to read, write and execute files on NFS by running the following commands:

```
sudo chown -R nobody: /mnt/apps
sudo chown -R nobody: /mnt/logs
sudo chown -R nobody: /mnt/opt

sudo chmod -R 777 /mnt/apps
sudo chmod -R 777 /mnt/logs
sudo chmod -R 777 /mnt/opt

sudo systemctl restart nfs-server.service
```

To Configure access to NFS for clients within the same subnet I opened the exports file located in the etc directory and the following commands were entered:


```
/mnt/apps <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash)
/mnt/logs <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash)
/mnt/opt <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash)
```
I ran the command below to check  which port is used by NFS and open it using Security Groups:

```
rpcinfo -p | grep nfs
```

*screenshot below*

 # CONFIGURE THE DATABASE SERVER

 The RHEL repositries were updated and Mysql was installed. I then created a database called tooling, a database user (webaccess) and granted permission to webaccess user on tooling database to do anything only from the webservers subnet cidr. 

 *Screenshot showing database has been created*

## Prepare the Web Servers

During this process I did the following:

1. Configured NFS client on 3 web servers
1. Deployed a Tooling application to my Web Servers into a shared NFS folder
1. Configured the Web Servers to work with a single MySQL database

I launched 3 new EC2 instance with RHEL 8 Operating System, updated the respositries and installed NFS. 

A www directory was created and the NFS server export for apps was mounted on using the below commands:

```
sudo mkdir /var/www
sudo mount -t nfs -o rw,nosuid <NFS-Server-Private-IP-Address>:/mnt/apps /var/www
```

I verified NFS was mounted succesfully:

*screenshot below*

To ensure that the changes will will persist on Web Server after reboot I entered the below command into the ftsab file which is located in the ect directory:

```
<NFS-Server-Private-IP-Address>:/mnt/apps /var/www nfs defaults 0 0
```

The following commands were entered to install Remi’s repository, Apache and PHP:

```
sudo yum install httpd -y

sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm

sudo dnf module reset php

sudo dnf module enable php:remi-7.4

sudo dnf install php php-opcache php-gd php-curl php-mysqlnd

sudo systemctl start php-fpm

sudo systemctl enable php-fpm

sudo setsebool -P httpd_execmem 1
```

To verify whether NFS was mounted correctly I created a new file touch test.txt from one server and checked whether it was visible within my NFS server:

*screenshot below*

The log file for Apache was located on the Web Server and mounted to the NFS server’s export for logs.

*screenshot below*

Git was installed and tooling source code from Darey.io was forked into my github account. The tooling website’s code was deployed to the Webserver and the html folder from the repository was also deployed to /var/www/html

I disable SELinux sudo setenforce 0 and to make this change permanent – opened  config file /etc/sysconfig/selinux and set SELINUX=disabledthen restrt httpd.

Updated the website’s configuration to connect to the database (in /var/www/html/functions.php file)

Appllied tooling-db.sql script to my database using this command:

```
 mysql -h <databse-private-ip> -u <db-username> -p <db-pasword> < tooling-db.sql
```

The elow website was generated using the public ip address and I was able to login!

*screenshot*