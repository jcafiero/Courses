/********
 * Name: Jennifer Cafiero
 * Date: May 5, 2019
 * CS554 Lab 7 - Lab 1 Revisited
 * mongoConnection.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

import { Db, MongoClient } from 'mongodb';

const settings = {
  "mongoConfig": {
    "serverURL": "mongodb://localhost:27017/",
    "database": "Cafiero-Jennifer-CS554-Lab7"
  }
};

let connection: MongoClient;
let db: Db;

// let fullMongoURL = settings.mongoConfig.serverURL + settings.mongoConfig.database;

export default async () => {
  if (!connection) {
    connection = await MongoClient.connect(
      settings.mongoConfig.serverURL,
      { useNewUrlParser: true }
    );
    db = await connection.db(settings.mongoConfig.database);
  }
  return db;
};
