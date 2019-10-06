/*
 * Author: Jennifer Cafiero
 * data.js - Lab 4
 * I pledge my honor that I have abided by the Stevens Honor System.
 */
const fs = require('fs');
const redis = require("redis");
const client = redis.createClient();
const dummy = JSON.parse(fs.readFileSync(`dummy.json`).toString());

function getPersonById(id) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (dummy[id - 1]) {
        resolve(dummy[id - 1]);
      } else {
        reject(new Error(`${id} is not a valid id for a person in this data set`));
      }
    }, 5000);
  });
}
async function readCache(max) {
  return (await client.lrangeAsync('people', 0, max)).map(JSON.parse)
}

module.exports = { getPersonById, readCache }