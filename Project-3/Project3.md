# MERN PROJECT


**MERN** Web stack consists of following components:
1. MongoDB: A document-based, No-SQL database used to store application data in a form of documents
1. ExpressJS: A server side Web Application framework for Node.js.
1. ReactJS: A frontend framework developed by Facebook. It is based on JavaScript, used to build User Interface (UI) components.
1. Node.js: A JavaScript runtime environment. It is used to run JavaScript on a machine rather than in a browser.


## BACKEND CONFIGURATION

I updated and upgraded ubuntu using the following commands: 

```
sudo apt update  

sudo apt upgrade
````

The location of Node.js was found from Ubuntu repositries by running command: 
```
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
```

*Screenshot below*
 

Node.js was installed by running command: sudo apt-get install -y nodejs

The command above installs both nodejs and npm. NPM is a package manager for Node like apt for Ubuntu, it is used to install Node modules & packages and to manage dependency conflicts.

The node installation was verified with the commands below: 

```
node -v 
```

```
npm -v 
```
*Screenshot below*
                                                                       
I then Created a new directory for your To-Do project using command: mkdir Todo
                                                                     

The command npm init was entered to initialise my project, so that a new file named package.json will be created. This file will normally contain information about your application and the dependencies that it needs to run.
```
npm init
```

*Screenshot to confirm that I  have package.json file created.*


## INSTALL EXPRESSJS

                                 
Installed express using command: npm install express


created a file index.js with the command and confirmed that it was made with the command ls: touch index.js

*Screenshot below*

Installed the dotenv module: npm install dotenv

Opened the index.js file with the command: vim index.js

Here is a *screenshot* of the code that was typed into the file: 

The terminal was oepned in the same directory as my index.js file.

                                                       
I confirmed the server was working by running command: node index.js
                                                       
created an inbound rule to open TCP port 5000.

*Screenshot below*

*Accessed my server’s Public IP on my browser*

For each task, I created routes that will define various endpoints that the To-do app will depend on. 

                                             
Routes folder was created by running commad: mkdir routes

Changed directory to routes folder and created a file api.js with commands:

cd routes

touch api.js

Opened the file with command : vim api.js

Copied below code in the file: 

const express = require ('express');
const router = express.Router();

router.get('/todos', (req, res, next) => {

});

router.post('/todos', (req, res, next) => {

});

router.delete('/todos/:id', (req, res, next) => {

})

module.exports = router;

### MODELS

Due to the app making use of Mongodb, which is a NoSQL database, I created a model. A model is at the heart of JavaScript based applications, and it is what makes it interactive. The models were to define the database schema. To create a Schema and a model, I installed mongoose which is a Node.js package that makes working with mongodb easier.

Changed directory back Todo folder with cd .. and installef Mongoose: npm install mongoose

Created a new modes folder and then changed directory into the newly created ‘models’ folder with the commands: 


mkdir models

cd models

Inside the models folder, created a file and named it todo.js: touch todo.js

Opened the file created with vim todo.js then paste the code below in the file:

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

//create schema for todo
const TodoSchema = new Schema({
action: {
type: String,
required: [true, 'The todo text field is required']
}
})

//create model for todo
const Todo = mongoose.model('todo', TodoSchema);

module.exports = Todo;

I then updated routes from the file api.js in ‘routes’ directory to make use of the new model with the following code:

*Screenshot below*

## MONGODB DATABASE

In the index.js file, I specified process.env to access environment variables, therefore this file was created in the Todo directory:

touch .env
vi .env

Addrf the connection string bto access the database in it, just as below:

DB = 'mongodb+srv://<username>:<password>@<network-address>/<dbname>?retryWrites=true&w=majority'

 To reflect the use of .env so that Node.js can connect to the database, the existing content in the file index.js was deleted, and updated it with the entire code below: 

 **Screenshot below**

Started the server using the command: node index.js

Opened Postman, created a POST request to the API http://<PublicIP-or-PublicDNS>:5000/api/todos. This request sends a new task to my To-Do list so the application could store it in the database.

Created a GET request to the API on http://<PublicIP-or-PublicDNS>:5000/api/todos. This request retrieves all existing records from out To-do application

## FRONTEND CREATION

Aim is to create a user interface for a Web client (browser) to interact with the application via API. To start out with the frontend of the To-do app, I used the create-react-app command to scaffold our app

The command below was run In the same root directory as the backend code, which is the Todo directory. This will create a new folder in the Todo directory called client, where all the react code will be placed.

npx create-react-app client

### Running a React App

Before testing the react app, there are some dependencies that need to be installed. concurrently is used to run more than one command simultaneously from the same terminal window. nodemon is used to run and monitor the server

Install concurrently: npm install concurrently --save-dev

Install nodemon: npm install nodemon --save-dev

The code highlighted below in the package.json file was replace with the code below@ 

### Configure Proxy in package.json

Changed directory to ‘client: cd client

Opened the package.json file: vi package.json

Added the key value pair in the package.json file: "proxy": "http://localhost:5000"

Run command in Todo Directory: npm run dev