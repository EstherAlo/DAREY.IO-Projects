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
 
![Pic5a](./images/Pic5a.png)

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

   ![Pic6a](./images/Pic6a.png)          


I then Created a new directory for your To-Do project using command: mkdir Todo


*Screeshot below*

   ![Pic6b](./images/Pic6b.png)                                                                  

The command npm init was entered to initialise my project, so that a new file named package.json will be created. This file will normally contain information about your application and the dependencies that it needs to run.

```
npm init
```

*Screenshot below*  
![Pic7a](./images/Pic7a.png)


## INSTALL EXPRESSJS

                                 
Installed express using command: npm install express

               
created a file index.js with the command and confirmed that it was made with the command ls: touch index.js

Installed the dotenv module: npm install dotenv

*Screenshot below*
![Pic8a](./images/Pic8a.png)

Code below was added into index.js file:

```
const express = require('express');
require('dotenv').config();

const app = express();

const port = process.env.PORT || 5000;

app.use((req, res, next) => {
res.header("Access-Control-Allow-Origin", "\*");
res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
next();
});

app.use((req, res, next) => {
res.send('Welcome to Express');
});

app.listen(port, () => {
console.log(`Server running on port ${port}`)
});
```



                                                    
I confirmed the server was working by running command: node index.js

![Pic8b](./images/Pic8b.png)


                                                       
created an inbound rule to open TCP port 5000.

*Screenshot below*
![Pic1a](./images/Pic1a.png)

*Accessed my server’s Public IP on my browser*
![Pic2a](./images/Pic2a.png)

For each task, I created routes that will define various endpoints that the To-do app will depend on. 

                                             
Routes folder was created by running commad: mkdir routes

Changed directory to routes folder and created a file api.js with commands:

cd routes

touch api.js

Added code below into the file: 

```
const express = require ('express');
const router = express.Router();

router.get('/todos', (req, res, next) => {

});

router.post('/todos', (req, res, next) => {

});

router.delete('/todos/:id', (req, res, next) => {

})

module.exports = router;
```

### MODELS

Due to the app making use of Mongodb, which is a NoSQL database, I created a model. A model is at the heart of JavaScript based applications, and it is what makes it interactive. The models were to define the database schema. To create a Schema and a model, I installed mongoose which is a Node.js package that makes working with mongodb easier.

 installed Mongoose in the Todo Directory: npm install mongoose

*Screenshot below*
![Pic13a](./images/Pic13a.png)

Created a new modes folder and then changed directory into the newly created ‘models’ folder with the commands: 

```
mkdir models

cd models
```

Inside the models folder, created a file and named it todo.js: touch todo.js

Added the code below into the todo.js file:

```
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
```

I then updated routes from the file api.js in ‘routes’ directory to make use of the new model by deleting code in vim api.js and adding code below:

```
const express = require ('express');
const router = express.Router();
const Todo = require('../models/todo');

router.get('/todos', (req, res, next) => {

//this will return all the data, exposing only the id and action field to the client
Todo.find({}, 'action')
.then(data => res.json(data))
.catch(next)
});

router.post('/todos', (req, res, next) => {
if(req.body.action){
Todo.create(req.body)
.then(data => res.json(data))
.catch(next)
}else {
res.json({
error: "The input field is empty"
})
}
});

router.delete('/todos/:id', (req, res, next) => {
Todo.findOneAndDelete({"_id": req.params.id})
.then(data => res.json(data))
.catch(next)
})

module.exports = router;
```

## MONGODB DATABASE

mLab provides MongoDB database as a service solution. 

In the index.js file, we specified process.env to access environment variables. I Created, opened file in the Todo directory:

```
touch .env

vi .env
```

I Added the connection string to access the database in it, in the format below:

```
DB = 'mongodb+srv://<username>:<password>@<network-address>/<dbname>?retryWrites=true&w=majority'
```


 To reflect the use of .env so that Node.js can connect to the database, the existing content in the file index.js was deleted, and updated it with the entire code below: 


```
 const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const routes = require('./routes/api');
const path = require('path');
require('dotenv').config();

const app = express();

const port = process.env.PORT || 5000;

//connect to the database
mongoose.connect(process.env.DB, { useNewUrlParser: true, useUnifiedTopology: true })
.then(() => console.log(`Database connected successfully`))
.catch(err => console.log(err));

//since mongoose promise is depreciated, we overide it with node's promise
mongoose.Promise = global.Promise;

app.use((req, res, next) => {
res.header("Access-Control-Allow-Origin", "\*");
res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
next();
});

app.use(bodyParser.json());

app.use('/api', routes);

app.use((err, req, res, next) => {
console.log(err);
next();
});

app.listen(port, () => {
console.log(`Server running on port ${port}`)
});

```
Started the server using the command: node index.js

*Screenshot below*
![Pic14a](./images/Pic14a.png)

Opened Postman, created a POST request to the API http://<PublicIP-or-PublicDNS>:5000/api/todos. This request sends a new task to my To-Do list so the application could store it in the database.

*screenshot below*
![Pic15a](./images/Pic15a.png)

Created a GET request to the API on http://<PublicIP-or-PublicDNS>:5000/api/todos. This request retrieves all existing records from out To-do application

*screenshot below*
![Pic16a](./images/Pic16a.png)

## FRONTEND CREATION

Aim is to create a user interface for a Web client (browser) to interact with the application via API. To start out with the frontend of the To-do app, I used the create-react-app command to scaffold the app.

The command below was run In the same root directory as the backend code, which is the Todo directory. This will create a new folder in the Todo directory called client, where all the react code will be placed.

```
npx create-react-app client
```
*Screenshot below*
![Pic20a](./images/Pic20a.png)


### Running a React App

Before testing the react app, there are some dependencies that need to be installed. concurrently is used to run more than one command simultaneously from the same terminal window. nodemon is used to run and monitor the server

Install concurrently: npm install concurrently --save-dev

Install nodemon: npm install nodemon --save-dev

*Screenshot below*
![Pic21a](./images/Pic21a.png)

code below was used to partly replace code in the package.json file 

```
"scripts": {
"start": "node index.js",
"start-watch": "nodemon index.js",
"dev": "concurrently \"npm run start-watch\" \"cd client && npm start\""
},

```

### Configure Proxy in package.json


Opened the package.json file in client directory and added the key value pair in the package.json file: "proxy": "http://localhost:5000"

Entered following command in Todo Directory: npm run dev

*Screenshot below*


### Creating React Components

 For the Todo app, there will be two stateful components and one stateless component
![Pic23a](./images/Pic23a.png)

 Created components folder insde the src folder and made three files:

  ```                                                   
  touch Input.js ListTodo.js Todo.js                                          
  ```                                                 
                                                            
                                                            
 Inside the ‘components’ directory three files were created:
 
```
touch Input.js ListTodo.js Todo.js                                   
 ```

 Added code below into Input.js:

 ```
 import React, { Component } from 'react';
import axios from 'axios';

class Input extends Component {

state = {
action: ""
}

addTodo = () => {
const task = {action: this.state.action}

    if(task.action && task.action.length > 0){
      axios.post('/api/todos', task)
        .then(res => {
          if(res.data){
            this.props.getTodos();
            this.setState({action: ""})
          }
        })
        .catch(err => console.log(err))
    }else {
      console.log('input field required')
    }

}

handleChange = (e) => {
this.setState({
action: e.target.value
})
}

render() {
let { action } = this.state;
return (
<div>
<input type="text" onChange={this.handleChange} value={action} />
<button onClick={this.addTodo}>add todo</button>
</div>
)
}
}

export default Input
```

To make use of Axios, which is a Promise based HTTP client for the browser and node.js, I npm install axios:

Screenshot below:

## FRONTEND CREATION

Entered code below into ListTodo.js which is in the src folder:

import React from 'react';

```
const ListTodo = ({ todos, deleteTodo }) => {

return (
<ul>
{
todos &&
todos.length > 0 ?
(
todos.map(todo => {
return (
<li key={todo._id} onClick={() => deleteTodo(todo._id)}>{todo.action}</li>
)
})
)
:
(
<li>No todo(s) left</li>
)
}
</ul>
)
}

export default ListTodo
```

In the Todo.js file i wrote the following code: 

import React, {Component} from 'react';
import axios from 'axios';

import Input from './Input';
import ListTodo from './ListTodo';

class Todo extends Component {

state = {
todos: []
}

componentDidMount(){
this.getTodos();
}

getTodos = () => {
axios.get('/api/todos')
.then(res => {
if(res.data){
this.setState({
todos: res.data
})
}
})
.catch(err => console.log(err))
}

deleteTodo = (id) => {

    axios.delete(`/api/todos/${id}`)
      .then(res => {
        if(res.data){
          this.getTodos()
        }
      })
      .catch(err => console.log(err))

}

render() {
let { todos } = this.state;

    return(
      <div>
        <h1>My Todo(s)</h1>
        <Input getTodos={this.getTodos}/>
        <ListTodo todos={todos} deleteTodo={this.deleteTodo}/>
      </div>
    )

}
}

export default Todo;

In the src directory I opened added the code below into Apps.js:

```
import React from 'react';

import Todo from './components/Todo';
import './App.css';

const App = () => {
return (
<div className="App">
<Todo />
</div>
);
}

export default App;
```

Added code below into App.css:

```
.App {
text-align: center;
font-size: calc(10px + 2vmin);
width: 60%;
margin-left: auto;
margin-right: auto;
}

input {
height: 40px;
width: 50%;
border: none;
border-bottom: 2px #101113 solid;
background: none;
font-size: 1.5rem;
color: #787a80;
}

input:focus {
outline: none;
}

button {
width: 25%;
height: 45px;
border: none;
margin-left: 10px;
font-size: 25px;
background: #101113;
border-radius: 5px;
color: #787a80;
cursor: pointer;
}

button:focus {
outline: none;
}

ul {
list-style: none;
text-align: left;
padding: 15px;
background: #171a1f;
border-radius: 5px;
}

li {
padding: 15px;
font-size: 1.5rem;
margin-bottom: 15px;
background: #282c34;
border-radius: 5px;
overflow-wrap: break-word;
cursor: pointer;
}

@media only screen and (min-width: 300px) {
.App {
width: 80%;
}

input {
width: 100%
}

button {
width: 100%;
margin-top: 15px;
margin-left: 0;
}
}

@media only screen and (min-width: 640px) {
.App {
width: 60%;
}

input {
width: 50%;
}

button {
width: 30%;
margin-left: 10px;
margin-top: 0;
}
}

```

In the src directory I opened and added the code below into index.css:

```
body {
margin: 0;
padding: 0;
font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen",
"Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue",
sans-serif;
-webkit-font-smoothing: antialiased;
-moz-osx-font-smoothing: grayscale;
box-sizing: border-box;
background-color: #282c34;
color: #787a80;
}

code {
font-family: source-code-pro, Menlo, Monaco, Consolas, "Courier New",
monospace;
}

```
                                                
                                                
I went into the Todo directory and run command: npm run dev
                                                

                                                 
The To-Do app is ready and fully functional. Functionality:creating a task, deleting a task and viewing all your tasks.
