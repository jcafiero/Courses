/********
 * Name: Jennifer Cafiero
 * Date: October 25, 2017
 * CS546 Lab 7 - A Recipe API
 * seed.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const dbConnection = require("../config/mongoConnection");
const data = require("../data/");
const recipes = data.recipes;

dbConnection().then(db => {
    return db.dropDatabase().then(() => {
        return dbConnection;
    }).then((db) => {
        let title = "Toast";
        let ingredients = [
          {
            name: "White Bread",
            amount: "2 slices of bread"
          },
          {
            name: "Butter",
            amount: "1 tbsp"
          }
        ];
        let steps = [
          "Put two slices of bread in the toaster oven at 350 for 3 to 5 minutes.",
          "Remove bread from toaster and spread with desired amount of butter",
          "Enjoy your toast!"
        ];
        return recipes.addRecipe(title, ingredients, steps);
    }).then((toast) => {
        const id = toast._id;
        console.log('added recipe with id ' + id);
        recipes.addComment(id, "Gordon Ramsey", "My grandmother can make better toast than you!").then((newComment) => {
          console.log("Added comment by Gordon Ramsey");
        });
        recipes.addComment(id, "Jennifer Cafiero", "MMMMM My favorite recipe!").then((newComment) => {
          console.log("Added comment by Jennifer Cafiero")
          recipes.getComment(newComment._id).then((comment) => {
            console.log(comment);
          });
        });
    }).then(() => {
        console.log("Done seeding database");
        db.close();
    });
}, (error) => {
    console.error(error);
});
