/********
 * Name: Jennifer Cafiero
 * Date: January 28, 2019
 * CS554 Lab 1 - Reviewing API Development
 * mongoConnection.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const MongoClient = require("mongodb").MongoClient;

const settings = {
  "mongoConfig": {
    "serverURL": "mongodb://localhost:27017/",
    "database": "Cafiero-Jennifer-CS554-Lab1"
  }
};

let fullMongoURL = settings.mongoConfig.serverURL + settings.mongoConfig.database;
let _connection = undefined;

let connectDb = async () => {
  if (!_connection) {
    _connection = await MongoClient.connect(fullMongoURL);
  }
  return _connection;
};
module.exports = connectDb;
