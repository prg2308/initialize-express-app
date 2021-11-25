#!/bin/sh

if [ -z "$1" ]; then
  echo "Please enter the name of the repository"
  exit
fi

#Create a directory
mkdir "$1"
cd "$1" || exit

# Initialise and download express mongoose and ejs npm modules
npm init -y
npm i express mongoose ejs

# Create directories
mkdir controllers models public routes views utils

#Create a user model in models directory. To customise, just change the 'User' prefix
cd models || exit
touch model.js
printf "const mongoose = require('mongoose');
const { Schema } = mongoose

const userSchema = new Schema({
    //
})

module.exports = mongoose.model('User', userSchema)" >>model.js
cd ..

#Create an index.js in routes directory
cd routes || exit
touch index.js
printf "const express = require('express');
const router = express.Router();

// GET Home Page.

router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

module.exports = router;" >>index.js
cd ..

#Create a boilerplate index.ejs and error.ejs files in views directory
cd views || exit
mkdir partials
touch index.ejs
printf "<!DOCTYPE html>
<html lang='en'>
<head>
  <meta charset='UTF-8'>
  <meta http-equiv='X-UA-Compatible' content='IE=edge'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>Document</title>
</head>
<body>
  
</body>
</html>" >>index.ejs
touch error.ejs
cd ..

#Create css, js and images folders in public directory
cd public || exit
mkdir css js images
cd ..

#Create .gitignore file
touch .gitignore
touch README.md
echo "/node_modules" >>.gitignore
echo "# $1" >>README.md

#Create index.js file
touch index.js

#Javascript for a basic express app and mongoose connection logic
printf "const express = require('express')
const app = express()
const router = express.Router();
const path = require('path')
const methodOverride = require('method-override')
const mongoose = require('mongoose')
const indexRouter = require('./routes/index');

mongoose.connect('mongodb://localhost:27017/<dbname>', { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        console.log('Connected to mongod')
    })
    .catch((err) => {
        console.log('Connection Error', err);
    })

app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, '/views'));

app.use(express.urlencoded({ extended: true }))
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use(methodOverride('_method'));

//Routes go here

// Error Handler
app.use(function(err, req, res, next) {
  // render the error page
  res.render('error', {error});
});

app.listen(3000, () => {
    console.log('Hosted on port 3000')
})" >>index.js #Write it into the Javascript file

#Initialize git repository
git init

#Stage all changes (Created files and folders)
git add .

#Commit changes
git commit -m "Initial commit"

#Open repository on vscode
code .
