/********
 * Name: Jennifer Cafiero
 * Date: May 5, 2019
 * CS554 Lab 7 - Lab 1 Revisited
 * index.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/


import { Express, Request, Response } from "express";
const tasks = require("./tasks");

const constructorMethod = (app: Express) => {
  app.use("/api/tasks", tasks);

  app.use("*", (req: Request, res: Response) => {
    res.status(404).json({ error: "Route not found." });
  });
};

export default constructorMethod;
