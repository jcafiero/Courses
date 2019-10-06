/*****
 * Author: Jennifer Cafiero
 * Date: October 1, 2017
 * Lab 4 - Our First ToDo
 * mongoConnection.js
 * I pledge my honor that I have abided by the Stevens Honor System
 *****/

const MongoClient = require("mongodb").MongoClient;

const settings = {
  "mongoConfig": {
    "serverURL": "mongodb://localhost:27017/",
    "database": "lab4"
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
