/********
 * Name: Jennifer Cafiero
 * Date: May 5, 2019
 * CS554 Lab 7 - Lab 1 Revisited
 * recipes.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const mongoCollections = require('../../mongoCollections');
const uuidv4 = require('uuid/v4');
const tasks = mongoCollections.tasks;

module.exports = {

  getAllTasks: async function() {
    const taskCollection = await tasks();
    return taskCollection.find({}).project({
      "_id": 0
    }).toArray();
  },

  getTaskById: async function(id) {
    if (!id) throw "Error: must provide an id";
    if (typeof id !== "string") throw "Error: id must be a string";

    const taskCollection = await tasks();
    const foundTask = await taskCollection.findOne({
      id: id
    },{
      "_id": 0
    });
    
    if (!foundTask) throw "Error: recipe not found";
    return foundTask;
  },

  addTask: async function(title, description, hoursEstimated) {
    if (!title) throw "Error: must provide a title";
    if (!description) throw "Error: must provide a description";
    if (!hoursEstimated) throw "Error: must provide a time estimate";
    if (typeof title !== "string") throw "Error: title must be a string";
    if (typeof description !== "string") throw "Error: description must be a string";
    if (typeof hoursEstimated !== "number") throw "Error: hoursEstimated must be a number";
    
    const taskCollection = await tasks();
    let newTask = {
      id: uuidv4(),
      title: title,
      description: description,
      hoursEstimated: hoursEstimated,
      completed: false,
      comments: []
    };
    const insertTask = await taskCollection.insertOne(newTask);
    if (insertTask.insertedCount === 0) throw "Error: could not insert task";
    return await this.getTaskById(newTask.id);
  },


  removeTask: async function(id) {
    if (!id) throw "Error: must provide an id";
    if (typeof id !== "string") throw "Error: id must be a string";

    const taskCollection = await tasks();

    const deletionInfo = await taskCollection.removeOne({
      id: id
    });

    if (deletionInfo.deletedCount === 0) throw `Error: could not remove task with id ${id}`;

    return true;
  },

  updateTask: async function(id, updatedTask) {
    if (!id) throw "Error: must provide an id";
    if (typeof id !== "string") throw "Error: id must be a string";
    if (!updatedTask) throw "Error: must provide a task";
    if (typeof updatedTask !== "object") throw "Error: task must be an object";
    if (!updatedTask.title) throw "Error: must provide a title";
    if (!updatedTask.description) throw "Error: must provide a description";
    if (!updatedTask.hoursEstimated) throw "Error: must provide a time estimate";
    // if (!updatedTask.completed) throw "Error: must provide if completed";
    if (typeof updatedTask.title !== "string") throw "Error: title must be a string";
    if (typeof updatedTask.description !== "string") throw "Error: description must be a string";
    if (typeof updatedTask.hoursEstimated !== "number") throw "Error: hoursEstimated must be a number";
    // if (typeof updatedTask.completed !== "boolean") throw "Error: completed must be a boolean"; 

    await this.getTaskById(id);

    let taskUpdateInfo = {
      title: updatedTask.title,
      description: updatedTask.description,
      hoursEstimated: updatedTask.hoursEstimated,
      completed: updatedTask.completed
    }

    const taskCollection = await tasks();
    await taskCollection.updateOne({
      id: id
    }, {
      $set: taskUpdateInfo
    });
    return await this.getTaskById(id);
  },
  addComment: async function(taskId, name, comment) {
    if (!taskId) throw "Error: must provide a id";
    if (!name) throw "Error: must provide a name";
    if (!comment) throw "Error: must provide a comment";
    if (typeof taskId !== "string") throw "Error: id must be a string";
    if (typeof name !== "string") throw "Error: name must be a string";
    if (typeof comment !== "string") throw "Error: comment must be a string";

    let newComment = {
      id: uuidv4(),
      name: name,
      comment: comment
    };
    
    const taskCollection = await tasks();

    //make sure that the task is in the collection before proceeding
    let task = await this.getTaskById(taskId);

    //push new comments to a list as opposed to above where we updated task info with $set (to overwrite existing)
    const insertComment = await taskCollection.updateOne({id : taskId}, {$push: { comments: newComment}});
    if (insertComment.insertedCount === 0) throw "Error: could not insert comment";

    return await this.getTaskById(taskId);
  },

  removeComment: async function(taskId, commentId) {
    if (!taskId) throw "Error: must provide a task id";
    if (!commentId) throw "Error: must provide a comment id";
    if (typeof taskId !== "string") throw "Error: task id must be a string";
    if (typeof commentId !== "string") throw "Error: comment id must be a string";

    const taskCollection = await tasks();

    await this.getTaskById(taskId);

    const deletionInfo = await taskCollection.updateOne({
      id: taskId
    }, { $pull: { comments: { id: commentId } } });

    if (deletionInfo.deletedCount === 0) throw `Error: could not remove comment with id ${commentId}`;

    return await this.getTaskById(taskId);

  }
};

