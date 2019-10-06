/***
 * Author: Jennifer Cafiero
 * CS 546 Lab 6 - JSON Routes
 * Date: October 16, 2017
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
***/

const express = require('express');
let app = express();
let configRoutes = require("./routes");

configRoutes(app);

app.listen(3000, () => {
    console.log("We've now got a server!");
    console.log("Your routes will be running on http://localhost:3000");
});
