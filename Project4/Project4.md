
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

                         
Command to install NodeJs: sudo apt install -y nodejs
                          

*Screenshot below*

![Pic2a](./images/NodeJs/Pic2a.png)

## Install MongoDB

MongoDB stores data in flexible, JSON-like documents. Fields in a database can vary from document to document and data structure can be changed over time. I will be adding book records to MongoDB that contain book name, isbn number, author, and number of pages.


                                          
Ran following command to install MongoDB: sudo apt install -y mongodb
                                          
  
Started and run the server by running the commands below:

```
sudo service mongodb start

sudo systemctl status mongodb
```


*Screenshot below*

![Pic1a](./images/MongoDB/Pic1a.png)

Ran following command to install npm – Node package manager: 
 

```
sudo apt install -y npm
```


*Screenshot below*

![Pic2a](./images/MongoDB/Pic2a.png)


                                                  
Installed body-parser package by running command: sudo npm install body-parser
                                                  

I created a books directory and initilized npm project 


```
mkdir Books && cd Books

npm init
```


*Screenshot below*

![Pic3a](./images/MongoDB/Pic3a.png)

Added a file names server.js and eneterd the web server code:

```
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
app.use(express.static(__dirname + '/public'));
app.use(bodyParser.json());
require('./apps/routes')(app);
app.set('port', 3300);
app.listen(app.get('port'), function() {
    console.log('Server up: http://localhost:' + app.get('port'));
});

```


## Install Express and set up routes to the server

Express is a minimal and flexible Node.js web application framework that provides features for web and mobile applications. I will use Express to pass book information to and from our MongoDB database.

I also will use Mongoose package which provides a straight-forward, schema-based solution to model the application data. I will use Mongoose to establish a schema for the database to store data of the book register.


                                              
                                              
run this command to install express mongoose: sudo npm install express mongoose
                                              


In ‘Books’ folder, I created a folder named apps. I then created a file named routes.js. I entered code and used cat to confirm that it was entered correctly.

*screenshot below*

![Pic1a](./images/Next/Pic1a.png)


In the ‘apps’ folder, a folder named models was created. I opened a file named book.js and entered and saved code within this file.

*Screenshot below*

![Pic2a](./images/Next/Pic2a.png)


 ## Access the routes with AngularJS

 I created a folder named public, added  a file named script.js. Code was added into this file.

 *Screenshot below*

![Pic3a](./images/Next/Pic3a.png)



