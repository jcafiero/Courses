/********
 * Name: Jennifer Cafiero
 * Date: October 25, 2017
 * CS546 Lab 7 - A Recipe API
 * app.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/
const bodyParser = require('body-parser');
const express = require('express');
let app = express();
let configRoutes = require('./routes');

app.use(bodyParser.json());
configRoutes(app);

app.listen(3000, () => {
  console.log("We've now got a server!");
  console.log("Your routes will be running on http://localhost:3000");
});
