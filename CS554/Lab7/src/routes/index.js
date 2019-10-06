"use strict";
/********
 * Name: Jennifer Cafiero
 * Date: May 5, 2019
 * CS554 Lab 7 - Lab 1 Revisited
 * index.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/
exports.__esModule = true;
var tasks = require("./tasks");
var constructorMethod = function (app) {
    app.use("/api/tasks", tasks);
    app.use("*", function (req, res) {
        res.status(404).json({ error: "Route not found." });
    });
};
exports["default"] = constructorMethod;
