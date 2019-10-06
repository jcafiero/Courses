/********
 * Name: Jennifer Cafiero
 * Date: October 25, 2017
 * CS546 Lab 7 - A Recipe API
 * comments.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const express = require('express');
const router = express.Router();
const data = require("../data");
const bodyParser = require('body-parser');
const recipeData = data.recipes;

router.get("/recipe/:recipeId", (req, res) => {
  recipeData.getAllComments(req.params.recipeId).then((comment) => {
    recipeData.getRecipe(req.params.recipeId).then((recipe) => {
      let specificRecipe = {
        _id: recipe._id,
        recipeTitle: recipe.title,
        comments: comment
      }
      res.json(specificRecipe);
    });
  }).catch((e) => {
    res.status(404).json({error: e});
  });
});

router.get("/:commentId", (req, res) => {
    recipeData.getComment(req.params.commentId).then((comment) => {
        recipeData.getRecipe(comment._id).then((recipe) => {
            let specificRecipe = {
                _id: comment.comments._id,
                recipeId: recipe._id,
                recipeTitle: recipe.title,
                poster: comment.comments[0].poster,
                comment: comment.comments[0].comment
            }
            res.json(result);
        });
    }).catch(() => {
        res.status(404).json({ error: "Specific comment not found" });
    });
});

router.post("/:recipeId", (req, res) => {
    let recipeID = req.params.recipeId;
    let commentInfo = req.body;
    if (!commentInfo) {
        res.status(400).json({ error: "Must enter data for comment" });
    }
    if (!commentInfo.poster) {
        res.status(400).json({ error: "Must enter poster data" });
    }
    if (!commentInfo.comment) {
        res.status(400).json({ error: "Must enter comment data" });
    }
    recipeData.addComment(recipeID, commentInfo.poster, commentInfo.comment).then((newComment) => {
        console.log("RecipeID: " + recipeID)
        console.log("Poster: " + commentInfo.poster)
        console.log("Comment: " + commentInfo.comment);
        res.json(newComment);
    }).catch((e) => {
        res.status(500).json({ error: e });
    });
});

router.put("/:recipeId/:commentId", (req, res) => {
    let updatingComment = req.body;
    let getComment = recipeData.getComment(req.params.commentId);
    getComment.then(() => {
        return recipeData.updateComment(req.params.recipeId, req.params.commentId, updatedData)
            .then((updatedComment) => {
                res.json(updatedComment);
            }).catch((e) => {
                console.log(e);
                res.status(500).json({ error: e });
            });
    }).catch((e) => {
        res.status(404).json({ error: e });
    });

});

router.delete("/:id", (req, res) => {
    let specComment = recipeData.getCommentById(req.params.id);
    specComment.then(() => {
        return recipeData.removeComment(req.params.id).then(() => {
            res.sendStatus(200);
        }).catch((e) => {
            res.status(500).json({ error: e });
        });
    }).catch((e) => {
        res.status(404).json({ error: e });
    });
});


module.exports = router;
