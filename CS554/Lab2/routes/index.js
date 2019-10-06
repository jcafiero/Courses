/********
 * Name: Jennifer Cafiero
 * Date: February 21, 2019
 * CS554 Lab 2
 * index.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

// const shop = require("./shop");
let express = require('express'); 

const constructorMethod = (app) => {
  app.use("/", express.static('shop'));

  app.use("*", (req, res) => {
    res.sendStatus(404);
  });
};

module.exports = constructorMethod;