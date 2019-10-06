/*****
 * Author: Jennifer Cafiero
 * Date: October 1, 2017
 * Lab 4 - Our First ToDo
 * app.js
 * I pledge my honor that I have abided by the Stevens Honor System
 *****/

const todo = require("./todo");
const mongodb = require("./mongoConnection");

async function main() {
  // 1. Create a task with the following details
  try {
    const dinosaurs = await todo.createTask("Ponder Dinosaurs", "Has Anyone Really Been Far Even as Decided to Use Even Go Want to do Look More Like?");
    console.log("Added 'Ponder Dinosaurs' to the todo list");
    console.log(dinosaurs);
  } catch (e) {
    console.log("Error completing Step 1");
  }
  // 2. Log the task and then create a new task with the following details
  try {
    const pokemon = await todo.createTask("Play Pokemon with Twitch TV", "Should we revive Helix?");
    console.log("Added 'Play Pokemon with Twitch TV' to the todo list");
    console.log(pokemon);
  } catch (e) {
    console.log("Error completing Step 2");
  }
  //After the task is inserted, query all tasks and log them
  try {
    const querytasks = await todo.getAllTasks();
    console.log(querytasks);
  } catch (e) {
    console.log("Error completing Step 3");
  }

  //After all the tasks are logged, remove the first task
  try {
    const querytasks = await todo.getAllTasks();
    await todo.removeTask(querytasks[0]._id);
    console.log("Removed the first task");
  } catch (e) {
    console.log("Error completing Step 4");
    console.log(e);
  }

  //Query all the remaining tasks and log them
  const querytasks2 = await todo.getAllTasks();
  console.log(querytasks2);
  console.log("All tasks queried");

  //Complete the remaining task
  await todo.completeTask(querytasks2[0]._id);
  console.log("Task marked as completed");

  //Log the task that has been completed with its new value
  const querytask3 = await todo.getTask(querytasks2[0]._id);
  console.log("Remaining task has been completed:");
  console.log(querytask3);

  const db = await mongodb();
  await db.close();

  console.log("Finished, database closed!");

}
main();
