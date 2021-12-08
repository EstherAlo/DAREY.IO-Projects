# Project Web Solution With WordPress

The aim of this project was prepare storage infrastructure on two Linux servers and implement a basic web solution using WordPress

Project 6 consists of two parts:

1. Configure storage subsystem for Web and Database servers based on Linux OS. 
1. Install WordPress and connect it to a remote MySQL database server.

## LAUNCH AN EC2 INSTANCE THAT WILL SERVE AS “WEB SERVER”

Launched an EC2 instance that will serve as "Web Server" and attached three volumes. To inspect what block devices are attached to the server I Used the this command: lsblk 

*screenshot*


To see all mounts and free space on the server I used the following command: 

 df -h 

*screenshot*


I used gdisk utility to create a single partition on each of the 3 disks and then to view the newly configured partition on each of the 3 disks the lsblk command: 

*screenshot*

I run the following command to install lvm2: sudo yum install lvm2

Used pvcreate utility to mark each of 3 disks as physical volumes (PVs) to be used by LVM and verified that the physical volumes has been created successfully

```
sudo pvcreate /dev/xvdf1
sudo pvcreate /dev/xvdg1
sudo pvcreate /dev/xvdh1
```

*screenshot below*

to add all 3 PVs to a volume group (VG) I run the following command:

```
sudo vgcreate webdata-vg /dev/xvdh1 /dev/xvdg1 /dev/xvdf1
```
                                                                
Verification that the VG has been created successfully by running:

```
sudo vgs
```

*screenshot below*

I created 2 logical volumes. apps-lv, and logs-lv. apps-lv will be used to store data for the Website while, logs-lv will be used to store data for logs

```
sudo lvcreate -n apps-lv -L 14G webdata-vg
sudo lvcreate -n logs-lv -L 14G webdata-vg
```

I verfied that the Logical Volume had been created successfully by running: 

```
sudo lvs
```

To confirm the whole set up I ran the following commands:

```
sudo vgdisplay -v #view complete setup - VG, PV, and LV

sudo lsblk 
```
*screenshot below*

I used mkfs.ext4 to format the logical volumes with ext4 filesystem with the commands below: 

```
sudo mkfs -t ext4 /dev/webdata-vg/apps-lv
sudo mkfs -t ext4 /dev/webdata-vg/logs-lv
```

To create a directory to store website files and also mount this i run the following comand:

```
sudo mkdir -p /var/www/html

sudo mount /dev/webdata-vg/apps-lv /var/www/html/
```

I then created a directory to store backup log data with the below command: 

```
sudo mkdir -p /home/recovery/logs
```

Before mmounting the fie system I backedup all the files in the log directory /var/log into /home/recovery/logs by running this command:

```
sudo rsync -av /var/log/. /home/recovery/logs/
```

