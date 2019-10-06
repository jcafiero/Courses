/***
 * Author: Jennifer Cafiero
 * CS 546 Lab 6 - JSON Routes
 * Date: October 16, 2017
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
***/
const express = require("express");
const about = require("./about");
const education = require("./education");
const story = require("./story");

const constructorMethod = (app) => {
  app.use("/about", about);
  app.use("/education", education);
  app.use("/story", story);

  app.use("*", (req, res) => {
    res.status(404).json({error: "Not found"});
  });
};


module.exports = constructorMethod;
