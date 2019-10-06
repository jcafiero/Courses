/********
 * Name: Jennifer Cafiero
 * Date: January 28, 2019
 * CS554 Lab 1 - Reviewing API Development
 * index.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const tasks = require("./tasks");
const log = require("../middleware/log");

const constructorMethod = (app) => {
  app.use("/api/tasks", log.requestBody, log.requestUrlCount, tasks);

  app.use("*", (req, res) => {
    res.sendStatus(404);
  });
};

module.exports = constructorMethod;
