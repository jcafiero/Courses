/***
 * Author: Jennifer Cafiero
 * CS 546 Lab 6 - JSON Routes
 * Date: October 16, 2017
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
***/

const express = require("express");
const router = express.Router();
const about =
  {
    "name": "Jennifer Cafiero",
    "biography": "I was born on September 29th, 1996 to Anne and Stephen Cafiero in JFK hospital. I have an older brother, John, and two younger brothers, Stephen and Christopher. I was raised in the suburbs of Clark, NJ and my first school was a five minute walk from my house. \nMost of my life has been spent in school. I have been involved in a lot of extracurriculars over my 21 years of life: Cheerleading, Soccer, a ton of Dance classes, Girl Scouts, the school newspaper, Yearbook, my sorority Theta Phi Alpha, and so many other things I can't think of right now.",
    "favoriteShows": ["Pretty Little Liars", "Grey's Anatomy", "Criminal Minds", "Friends", "How I Met Your Mother", "Law and Order: SVU"],
    "hobbies":["Crochet", "Making websites", "Sisterhood bonding", "Cooking", "Baking", "Midafternoon naps", "Interviewing for co-ops (jk)"]
  };
router.get("/", (req, res) => {
  try {
    res.json(about);
  } catch(e) {
    res.status(500).send("Server error: " + e);
  }
});
module.exports = router;
