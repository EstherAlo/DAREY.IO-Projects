
# MEAN PROJECT

## MEAN STACK DEPLOYMENT TO UBUNTU IN AWS

MEAN Stack is a combination of following components:

1. MongoDB (Document database) – Stores and allows to retrieve data.
1. xpress (Back-end application framework) – Makes requests to Database for Reads and Writes.
1. Angular (Front-end application framework) – Handles Client and Server Requests
1. Node.js (JavaScript runtime environment) – Accepts requests and displays results to end user. This will set up the Express routes and AngularJS controllers.

Install NodeJs

Firstly I updated and upgraded ubuntu before installation of Nodejs by running commands:

```
sudo apt update

sudo apt upgrade
```
 
Added certificates with the command below:

```
sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash 
```



                           ```
Command to install NodeJs: sudo apt install -y nodejs
                           ```

*Screenshot below*

![Pic2a](./images/NodeJs/Pic2a.png)

