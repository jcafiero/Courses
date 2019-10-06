/***
 * Author: Jennifer Cafiero
 * CS 546 Lab 6 - JSON Routes
 * Date: October 16, 2017
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
***/
const express = require("express");
const router = express.Router();
const education = [
  {
    "schoolName": "Saint John the Apostle",
    "degree": "Primary school diploma (I don't know)",
    "favoriteClass": "Nap time",
    "favoriteMemory": "I fell off the stage at one of our school plays. Basically just walked straight off the stage. I was fine somehow, but it was a scary experience."
  },
  {
    "schoolName": "Academy for Information Technology",
    "degree": "High school degree",
    "favoriteClass": "SQL fundamentals",
    "favoriteMemory": "The bus rides to and from school"
  },
  {
    "schoolName": "Stevens Institute of Technology",
    "degree": "Bachelor of Science",
    "favoriteClass": "Web Programming",
    "favoriteMemory": "One time freshman year my friends put mayonaise in my froyo in the dining hall. It tasted terrible - imagine wanting to taste vanilla froyo and getting mayo instead. Memorable, but very terrible."
  }
];
router.get("/", (req, res) => {
  try {
    res.json(education);
  } catch(e) {
    res.status(500).send("Server error: " + e);
  }
});
module.exports = router;
