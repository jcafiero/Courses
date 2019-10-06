"use strict";
exports.__esModule = true;
/********
 * Name: Jennifer Cafiero
 * Date: May 5, 2019
 * CS554 Lab 7 - Lab 1 Revisited
 * app.ts
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/
var bodyParser = require("body-parser");
var express = require("express");
var routes_1 = require("./routes");
var app = express();
app.use(bodyParser.json());
app.use(function (req, res, next) {
    console.log("=============== REQUEST BODY LOGGER ===================");
    console.log("Request body: ");
    console.log(req.body);
    console.log("Request URL: " + req.headers.host + req.originalUrl);
    console.log("HTTP verb: " + req.method);
    console.log("=============== END REQUEST BODY LOGGER ===============");
    return next();
});
var reqUrl = {};
app.use(function (req, res, next) {
    console.log("=============== REQUEST URL TRACKER ===================");
    if (req.originalUrl in reqUrl) {
        reqUrl[req.originalUrl] += 1;
    }
    else {
        reqUrl[req.originalUrl] = 1;
    }
    console.log("URLs requested:");
    console.log(reqUrl);
    console.log("=============== END REQUEST URL TRACKER ===============");
    return next();
});
routes_1["default"](app);
app.listen(3000, function () {
    console.log("We've now got a server!");
    console.log("Your routes will be running on http://localhost:3000");
});
