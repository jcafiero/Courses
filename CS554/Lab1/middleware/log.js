/********
 * Name: Jennifer Cafiero
 * Date: January 28, 2019
 * CS554 Lab 1 - Reviewing API Development
 * log.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

let reqUrl = {};

const requestBody = (req, res, next) => {
    console.log("=============== REQUEST BODY LOGGER ===================");
    console.log("Request body: ");
    console.log(req.body);
    console.log("Request URL: " + req.headers.host + req.originalUrl);
    console.log("HTTP verb: " + req.method);
    console.log("=============== END REQUEST BODY LOGGER ===============");
    return next();
};

const requestUrlCount = (req, res, next) => {
    console.log("=============== REQUEST URL TRACKER ===================");
    if (reqUrl[req.originalUrl]){
        reqUrl[req.originalUrl] += 1
    } else {
        reqUrl[req.originalUrl] = 1
    }
    console.log("URLs requested:");
    console.log(reqUrl);
    console.log("=============== END REQUEST URL TRACKER ===============");
    return next();
};

module.exports = {requestBody:requestBody, requestUrlCount:requestUrlCount};