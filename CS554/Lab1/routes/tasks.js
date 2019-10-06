/********
 * Name: Jennifer Cafiero
 * Date: January 28, 2019
 * CS554 Lab 1 - Reviewing API Development
 * recipes.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

const express = require('express');
const router = express.Router();
const data = require("../data");
const taskData = data.tasks;

//get all tasks
router.get("/", async (req, res) => {
  try {
    let skip = 0;
    let take = 20;
    if (req.query.skip) {
      skip = parseInt(req.query.skip);
      if (isNaN(skip)) throw "Error: querystring variable skip should be a number";
    }
    if (req.query.take) {
      take = parseInt(req.query.take);
      if (isNaN(take)) throw "Error: querystring variable take should be a number";
      if (take > 100) take = 100;
    }
      const taskList = await taskData.getAllTasks();
      res.json(taskList.slice(skip).slice(0, take));
  } catch (e) {
      console.log(e)
      res.status(500).json({
          error: e
      });
  }
});

//get single task by id
router.get("/:id", async (req, res) => {
  try {
      const task = await taskData.getTaskById(req.params.id);
      res.json(task);
  } catch (e) {
      console.log(e);
      res.status(404).json({
          error: e
      });
  }
});

//post new task
router.post("/", async (req, res) => {
  const taskInfo = req.body;

  if (!taskInfo) {
    res.status(400).json({
      error: "You must provide a task"
    });
    return;
  }
  if (!taskInfo.title) {
    res.status(400).json({
      error: "You must provide a task title"
    });
    return;
  }
  if (!taskInfo.description) {
    res.status(400).json({
      error: "You must provide a task description"
    });
    return;
  }
  if (!taskInfo.hoursEstimated) {
    res.status(400).json({
      error: "You must provide a time estimate for the task"
    });
    return;
  }
  // if (!taskInfo.completed) {
  //   res.status(400).json({
  //     error: "You must provide if the task is completed"
  //   });
  //   return;
  // }

  try {
    const newTask = await taskData.addTask(taskInfo.title, taskInfo.description, taskInfo.hoursEstimated);
    res.json(newTask);
  } catch (e) {
    console.log(e);
    res.status(500).json({
      error: e
    });
  }
});

//update the whole task
router.put("/:id", async (req, res) => {
  const taskInfo = req.body; 
  if (!taskInfo) {
    res.status(400).json({
        error: "You must provide a task to update"
    });
    return;
  }

  if (!taskInfo.title) {
      res.status(400).json({
          error: "You must provide a task title"
      });
      return;
  }

  if (!taskInfo.description) {
      res.status(400).json({
          error: "You must provide task description"
      });
      return;
  }

  if (!taskInfo.hoursEstimated) {
      res.status(400).json({
          error: "You must provide hours estimated"
      });
      return;
  }

  if (!taskInfo.completed) {
    res.status(400).json({
        error: "You must provide if completed"
    });
    return;
}

  try {
      await taskData.getTaskById(req.params.id);
  } catch (e) {
      console.log(e);
      res.status(404).json({
          error: e
      });
      return;
  }

  try {
      const updatedTask = await taskData.updateTask(req.params.id, taskInfo);
      res.json(updatedTask);
  } catch (e) {
      console.log(e);
      res.status(500).json({
          error: e
      });
  }
});

//update task only with included values
router.patch("/:id", async (req, res) => {
  const taskInfo = req.body;

  // error check 
  if (!taskInfo) {
      res.status(400).json({
          error: "You must provide a task to update"
      });
      return;
  }

  // hold current task to fill in any missing values
  let currentTask;
  try {
      currentTask = await taskData.getTaskById(req.params.id);
  } catch (e) {
      console.log(e);
      res.status(404).json({
          error: e
      });
      return;
  }

  // fill in missing values
  if (!taskInfo.title) {
      taskInfo.title = currentTask.title;
  }

  if (!taskInfo.description) {
      taskInfo.description = currentTask.description;
  }

  if (!taskInfo.hoursEstimated) {
      taskInfo.hoursEstimated = currentTask.hoursEstimated;
  }

  try {
      const updatedTask = await taskData.updateTask(req.params.id, taskInfo);
      res.json(updatedTask);
  } catch (e) {
      console.log(e);
      res.status(500).json({
          error: e
      });
  }
});

router.post("/:id/comments", async (req, res) => {
    const commentInfo = req.body;

  if (!commentInfo) {
    res.status(400).json({
      error: "You must provide a comment"
    });
    return;
  }
  if (!commentInfo.name) {
    res.status(400).json({
      error: "You must provide a comment name"
    });
    return;
  }
  if (!commentInfo.comment) {
    res.status(400).json({
      error: "You must provide a comment body"
    });
    return;
  }
  try {
    const newComment = await taskData.addComment(req.params.id, commentInfo.name, commentInfo.comment);
    res.json(newComment);
  } catch (e) {
    console.log(e);
    res.status(500).json({
      error: e
    });
  }
});

// delete comment by id on task by id
router.delete("/:taskId/:commentId", async (req, res) => {
  //verify that task exists
  try {
      await taskData.getTaskById(req.params.taskId);
  } catch (e) {
      console.log(e);
      res.status(404).json({
          error: e
      });
      return;
  }

  //remove comment
  try {
      await taskData.removeComment(req.params.taskId, req.params.commentId);
      res.sendStatus(200);
  } catch (e) {
      console.log(e);
      res.status(500).json({
          error: e
      });
  }
});


module.exports = router;
