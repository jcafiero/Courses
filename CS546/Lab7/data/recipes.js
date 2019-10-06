/********
 * Name: Jennifer Cafiero
 * Date: October 25, 2017
 * CS546 Lab 7 - A Recipe API
 * recipes.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const mongoCollections = require('../mongoCollections');
const uuid = require('node-uuid');
const recipes = mongoCollections.recipes;


let exportedMethods = {
  getAllRecipes() {
    return recipes().then((recipeList) => {
      return recipeList.find({}).toArray();
    })
  },
  getRecipe(id) {
    if (!id) return Promise.reject("No id provided");
    return recipes().then((recipeList) => {
      return recipeList.findOne({_id: id}).then((recipe) => {
        if (!recipe) throw "Recipe not found";
        return recipe;
      });
    });
  },
  addRecipe(title, ingredients, steps, comments) {
    if (!title) return Promise.reject("No title provided");
    if (!ingredients) return Promise.reject("No ingredients provided");
    if (!steps) return Promise.reject("No steps provided");
    return recipes().then((recipeList) => {
      let newRecipe = {
        _id: uuid.v4(),
        title: title,
        ingredients: ingredients,
        steps: steps,
        comments: []
      };
      return recipeList.insertOne(newRecipe).then((newInfo) => {
        return newInfo.insertedId;
      }).then((newId) => {
        return this.getRecipe(newId);
      });
    });
  },
  removeRecipe(id) {
    if (!id) return Promise.reject("Invalid recipe ID");
    return recipes().then((recipeList) => {
      return recipeList.removeOne({ _id: id}).then((removeInfo) => {
        if (removeInfo.deletedCount === 0) {
          error('Could not remove recipe with an id of: '+ id)
        }
      });
    });
  },
  updateRecipe(id, updatedRecipe) {
    if (!id) return Promise.reject("Invalid recipe ID");
    if (!updatedRecipe) return Promise.reject("Must provide updated information to update a recipe");
    return recipes().then((recipeList) => {
      let updatedInfo = {};
      if (updatedRecipe.title) {
        updatedInfo.title = updatedRecipe.title;
      }
      if (updatedRecipe.ingredients) {
        updatedInfo.ingredients = updatedRecipe.ingredients;
      }
      if (updatedRecipe.steps) {
        updatedInfo.steps = updatedRecipe.steps;
      }
      return recipeList.updateOne({_id: id}, {$set: updatedInfo}).then((result) => {
        return this.getRecipe(id);
      });
    });
  },
  addComment(recipeID, poster, comment) {
    if (!recipeID) return Promise.reject("Invalid recipe ID");
    if (!poster) return Promise.reject("Must enter poster");
    if (!comment) return Promise.reject("Must enter comment");
    return recipes().then((recipeList) => {
      let newComment = {
        _id: uuid.v4(),
        poster: poster,
        comment: comment
      };
      return recipeList.updateOne({_id: id}, {
        $addToList: {
          comments: comment
        }
      }).catch((e) => {
        return Promise.reject(e);
      });
    });

  },
  removeComment(commentID) {
    if (!commentID) return Promise.reject("Invalid comment ID");
    return recipes().then((recipeList) => {
      return recipeList.update({}, {$rem: {comments: {_id: commentID}}}, false, true).then((delComment) => {
        if (delComment.deletedCount === 0) {
          return Promise.reject('Could not delete comment with ID: ' + commentID);
        }
      }).catch((e) => {
        return Promise.reject(e);
      });
    });
  },
  updateComment(recipeID, commentID, updatedComment) {
    if (!recipeID) return Promise.reject("Invalid recipe ID");
    if (!commentID) return Promise.reject("Invalid comment ID");
    if (!updatedComment) return Promise.reject("You need to enter a new comment");

    return recipes().then((recipeList) => {
      let comment = {};
      if (updatedComment.poster) {
        comment.poster = updatedComment.poster;
      }
      if (updatedComment.comment) {
        comment.comment = updatedComment.comment;
      }
      comment._id = commentID;
      return recipeList.update({ "comments._id": commentID}, {
        $set: {"comments.$": comment}
      }).then(() => {
        return this.getComment(commentID);
      });
    });
  },
  getComment(commentID) {
    if (!commentID) return Promise.reject("Invalid comment ID");
    return recipes().then((recipeList) => {
      return recipeList.findOne({"comments._id": commentID}, {
        'comments.$': 1}).then((recipe) => {
          if (!recipe) error("Comment not found");
          return recipe.comments;
        })
      });
    }
  ,
  getAllComments(recipeID) {
    if (!recipeID) return Promise.reject("Invalid recipe ID");
    return recipes().then((recipeList) => {
      return recipeList.findOne({"_id":recipeID}).then((recipe) => {
        if (!recipe) error("Recipe listing not found");
        return recipe.comments;
      })
    });
  }

}
module.exports = exportedMethods;
