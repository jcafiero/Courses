/*
 * Author: Jennifer Cafiero
 * server.js - Lab 4
 * I pledge my honor that I have abided by the Stevens Honor System.
 */

const express = require("express");
const app = express();
const redis = require("redis");
const client = redis.createClient();

const data = require('./data');

require('bluebird').promisifyAll(redis.RedisClient.prototype)
require('bluebird').promisifyAll(redis.Multi.prototype)

app.get("/api/people/history", async (req, res) => {
  try {
    res.json(await data.readCache(19))
  } catch (e) {
    console.log(e);
    res.status(500).json({ error: e.message });
  }
});

app.get('/api/people/:id', async (req, res) => {
  try {
    //reads the cache that exists prior
    const cache = await data.readCache(-1);
    // console.log(cache);
    const id = Number(req.params.id);

    let person = cache.find((person) => {
      person.id === id
    });
    // console.log(person);
    if (person) {
      res.json(person);
    } else {
      try {
        person = await data.getPersonById(id);
        res.json(person);
      } catch (e) {
        console.log(e);
        return res.status(404).json({error: e.message});
      }
    }
    //pushes the accessed person object to the cache
    await client.lpushAsync('people', JSON.stringify(person));
  } catch (e) {
    console.log(e);
    return res.status(404).json({error: e.message});
  }
  
});

app.listen(3000, () => {
  console.log("We've now got a server!");
  console.log("Your routes will be running on http://localhost:3000");
});