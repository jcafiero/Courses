/*****
 * Author: Jennifer Cafiero
 * Date: October 1, 2017
 * Lab 4 - Our First ToDo
 * todo.js
 * I pledge my honor that I have abided by the Stevens Honor System
 *****/


const mongoCollections = require('./mongoCollections');
const uuid = require('uuid');
const todoItems = mongoCollections.todoItems;

module.exports = {
    async createTask(title, description) {
        if (!title) throw "You must provide a title name.";
        if (!description) throw "You must provide a description.";
        const todoCollection = await todoItems();
        let newTodo = {
          _id: uuid.v1(),
          title: title,
          description: description,
          completed: false,
          completedAt: null
        };

        const insertTodo = await todoCollection.insertOne(newTodo);
        if (insertTodo.insertedCount === 0) throw "Could not add todo";
        const newId = insertTodo.insertedId;
        const task = await this.getTask(newId);
        return task;

    },
    async getAllTasks() {
        const todoCollection = await todoItems();
        const todos = await todoCollection.find({}).toArray();
        return todos;

    },
    async getTask(id) {
        if (!id) throw "You must provide an ID to search for";

        const todoCollection = await todoItems();
        const task = await todoCollection.findOne({_id: id});

        if (task === null) throw "No task with that Id";

        return task;

    },
    async completeTask(taskId) {
        if (!taskId) throw "You must provide an ID to mark as completed";
        const todoCollection = await todoItems();
        const completedTodo = {
          completed: true,
          completedAt: new Date()
        };
        const completeTask = await todoCollection.updateOne({_id: taskId}, {$set: completedTodo});
        if (completedTodo.modifiedCount === 0) {
          throw "could not update todo successfully";
        }
        const compTask = await this.getTask(taskId);
        return compTask;

    },
    async removeTask(id) {

        if (!id) throw "You must provide an ID to search for";
        const todoCollection = await todoItems();

        const deletionInfo = await todoCollection.removeOne({ _id: id});
        if (deletionInfo.deleteCount === 0) {
          throw (`Could not delete item with ID of ${id}`);
        } else {
          console.log(`Deleted item with ID: ${id}`);
        }
    }
}
