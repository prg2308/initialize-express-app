#!/bin/sh

if [ -z "$1" ]; then
    echo "No filename specified"
    exit
fi

#Create a directory
mkdir "$1"
cd "$1" || exit

# Initialise and download express mongoose and ejs npm modules
npm init -y
npm i express mongoose ejs

# Create directories
mkdir controllers models public views utils
cd public || exit
mkdir css js
cd ..

#Create .gitignore file
touch .gitignore
echo "/node_modules" >>.gitignore

#Create index.js file
touch index.js

#Javascript for a basic express app and mongoose connection logic
printf "const express = require('express')
const app = express()
const router = express.Router();
const path = require('path')
const methodOverride = require('method-override')
const mongoose = require('mongoose')

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

app.listen(3000, () => {
    console.log('Hosted on port 3000')
})" >>index.js  #Write it into the Javascript file

#Initialize git repository
git init

#Stage all changes (Created files and folders)
git add .

#Commit changes
git commit -m "Initial commit"

#Open repository on vscode
code .
