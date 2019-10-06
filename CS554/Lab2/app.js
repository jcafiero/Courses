/********
 * Name: Jennifer Cafiero
 * Date: February 21, 2019
 * CS554 Lab 2
 * app.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const bodyParser = require('body-parser');
const express = require('express');
const static = express.static(__dirname + "/public");

let app = express();
let configRoutes = require('./routes');

app.use(bodyParser.json());
app.use('/public', static);

configRoutes(app);

app.listen(3000, () => {
  console.log("We've now got a server!");
  console.log("Your routes will be running on http://localhost:3000");
});