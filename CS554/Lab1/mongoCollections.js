/********
 * Name: Jennifer Cafiero
 * Date: January 28, 2019
 * CS554 Lab 1 - Reviewing API Development
 * mongoCollections.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/
const dbConnection = require("./mongoConnection");

const getCollectionFn = collection => {
  let _col = undefined;

  return async () => {
    if (!_col) {
      const db = await dbConnection();
      _col = await db.collection(collection);
    }
    return _col;
  };
};

module.exports = {
  tasks: getCollectionFn("tasks")
};
