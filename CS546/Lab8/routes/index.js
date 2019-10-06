/********
 * Name: Jennifer Cafiero
 * Date: November 9, 2017
 * CS546 Lab 8 - Palindromes
 * form.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/
const palindromeRoutes = require("./palindrome");

const constructorMethod = (app) => {
    app.use("/palindrome", palindromeRoutes);
    app.use("*", (req, res) => {
        res.redirect("/palindrome/static");
    });
};
module.exports = constructorMethod;
