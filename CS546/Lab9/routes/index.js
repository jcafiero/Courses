/*****
 * Author: Jennifer Cafiero
 * Date: November 20, 2017
 * CS546 Lab 9 - A Simple User Login System
 * I pledge my honor that I have abided by the Stevens Honor System
 *****/

const mainRoute = require("./main");
const constructorMethod = (app) => {
    app.use("/", mainRoute);
    app.use("*", (req, res) => {
        res.status(404).json({
            error: "Not found"
        });
    });
};
module.exports = constructorMethod;