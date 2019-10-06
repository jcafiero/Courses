/*****
 * Author: Jennifer Cafiero
 * Date: November 20, 2017
 * CS546 Lab 9 - A Simple User Login System
 * I pledge my honor that I have abided by the Stevens Honor System
 *****/

const userData = require("./users");

let constructorMethod = (app) => {
	app.use("/", userData);
};

module.exports = {
	users: userData
};