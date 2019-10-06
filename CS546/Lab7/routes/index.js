/********
 * Name: Jennifer Cafiero
 * Date: October 25, 2017
 * CS546 Lab 7 - A Recipe API
 * index.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const express = require("express");
const recipes = require("./recipes");
const comments = require("./comments");

const constructorMethod = (app) => {
  app.use("/recipes", recipes);
  app.use("/comments", comments);

  app.use("*", (req, res) => {
    res.status(404).json({error: "Not found"});
  });
};

module.exports = constructorMethod;
