/********
 * Name: Jennifer Cafiero
 * Date: October 25, 2017
 * CS546 Lab 7 - A Recipe API
 * recipes.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const express = require('express');
const router = express.Router();
const data = require("../data");
const bodyParser = require('body-parser');
const recipeData = data.recipes;

router.get("/:id", (req, res) => {
  recipeData.getRecipe(req.params.id).then((recipe) => {
    res.json(recipe);
  }, (error) => {
    res.status(404).json({message: "ID Not Found"});

  });
});

router.get("/", (req, res) => {
  recipeData.getAllRecipes().then((recipes) => {
    for (let i = 0; i < recipes.length; i++) {
      rep = {};
      rep._id = recipes[i]._id;
      rep.title = recipes[i].title;
      recipes[i] = rep;
    }
    res.json(recipes);
  }, () => {
    res.status(500).send();
  });
});

router.post("/", (req, res) => {
  let newRecipe = req.body;
  if (!newRecipe) {
    res.status(400).json({ error: "Must enter data for a recipe"});
  }
  if (!newRecipe.title) {
    res.status(400).json({error: "Must enter data for title"});
  }
  if (!newRecipe.ingredients) {
    res.status(400).json({error: "Must enter data for ingredients"});
  }
  if (!newRecipe.steps) {
    res.status(400).json({error: "Must enter data for steps"});
  }
  recipeData.addRecipe(newRecipe.title, newRecipe.ingredients, newRecipe.steps).then((new_recipe) => {
    res.json(new_recipe);
  }, () => {
    res.sendStatus(500);
  });
});

router.put("/:id", (req, res) => {
  let updatingRecipe = req.body;
  let getRecipe = recipeData.getRecipe(req.params.id);
  getRecipe.then(() => {
    return recipeData.updateRecipe(req.params.id, updatingRecipe).then((updated) => {
      res.json(updated);
    }).catch((e) => {
      res.status(500).json({error: e});
    });
  }).catch((e) => {
    res.status(404).json({error: e});
  });
});

router.delete("/:id", (req, res) => {
    let deletingRecipe = recipeData.getRecipe(req.params.id).then(() => {
        return recipeData.removeRecipe(req.params.id).then(() => {
            res.sendStatus(200);
        }).catch(() => {
            res.sendStatus(500);
        });
    }).catch(() => {
        res.status(404).json({ error: "Recipe data was not found" });
    });
});

module.exports = router;



module.exports = router;
