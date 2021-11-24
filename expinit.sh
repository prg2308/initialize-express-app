#!/bin/sh

if [ -z "$1" ]; then
    echo "No filename specified"
    exit
fi
mkdir "$1"
cd "$1" || exit
npm init -y
npm i express mongoose ejs
mkdir controllers models public views utils
cd public || exit
mkdir css js
cd ..
touch .gitignore
echo "/node_modules" >>.gitignore
touch index.js
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
})" >>index.js

git init
git add .
git commit -m "Initial commit"
code .
