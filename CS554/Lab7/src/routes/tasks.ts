/********
 * Name: Jennifer Cafiero
 * Date: May 5, 2019
 * CS554 Lab 7 - Lab 1 Revisited
 * recipes.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

import express = require('express');
import { Request, Response } from 'express';
import { Task } from "../../mongoCollections";
import { tasks } from "../data";

const router = express.Router();
const data = require("../data");
const taskData = data.tasks;

interface RequestBody {
    title: string;
    description: string;
    hoursEstimated: number;
    completed: boolean;
}

//function to validate request body input
function checkRequestBody(params: RequestBody): boolean {
    const { title, description, hoursEstimated, completed } = params;
  
    return (
      !!title && typeof title === "string" &&
      !!description && typeof description === "string" &&
      typeof hoursEstimated === "number" && hoursEstimated > 0 &&
      (typeof completed === "boolean" || completed === undefined)
    );
  }

//get all tasks
router.get("/", async (req: Request, res: Response): Promise<void> => {
  try {
    let skip: number = 0;
    let take: number = 20;
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
router.get("/:id", async (req: Request, res: Response): Promise<void> => {
  const taskID: string = req.params.id;
  try {
      const task = await taskData.getTaskById(taskID);
      res.json(task);
  } catch (e) {
      console.log(e);
      res.status(404).json({
          error: e
      });
  }
});

//post new task
router.post("/", async (req: Request, res: Response): Promise<void> => {
  const {title, description, hoursEstimated} = req.body;

  if (!title && !description && !hoursEstimated) {
    res.status(400).json({
      error: "You must provide a task"
    });
    return;
  }
  if (!title) {
    res.status(400).json({
      error: "You must provide a task title"
    });
    return;
  }
  if (!description) {
    res.status(400).json({
      error: "You must provide a task description"
    });
    return;
  }
  if (!hoursEstimated) {
    res.status(400).json({
      error: "You must provide a time estimate for the task"
    });
    return;
  }

  try {
    const newTask: Task = await taskData.addTask(title, description, hoursEstimated);
    res.json(newTask);
  } catch (e) {
    console.log(e);
    res.status(500).json({
      error: e
    });
  }
});

//update the whole task
router.put("/:id", async (req: Request, res: Response): Promise<void> => {
  const taskID: string = req.params.id;
  const { title, description, hoursEstimated, completed }:RequestBody = req.body;

  if (!req.body) {
    res.status(400).json({
        error: "You must provide a task to update"
    });
    return;
  }

  if (!title) {
      res.status(400).json({
          error: "You must provide a task title"
      });
      return;
  }

  if (!description) {
      res.status(400).json({
          error: "You must provide task description"
      });
      return;
  }

  if (!hoursEstimated) {
      res.status(400).json({
          error: "You must provide hours estimated"
      });
      return;
  }

  if (completed == null) {
    res.status(400).json({
        error: "You must provide if completed"
    });
    return;
}

  try {
      await taskData.getTaskById(taskID);
  } catch (e) {
      console.log(e);
      res.status(404).json({
          error: e
      });
      return;
  }

  try {
    const taskInfo: Task | null = await taskData.updateTask(taskID, {
        title,
        description,
        hoursEstimated,
        completed: completed === true
      });
      res.json(taskInfo);
  } catch (e) {
      console.log(e);
      res.status(500).json({
          error: e
      });
  }
});

//update task only with included values
router.patch("/:id", async (req: Request, res: Response): Promise<void> => {
  const taskID:string = req.params.id;
  const {title, description, hoursEstimated, completed} = req.body;
  console.log(completed);
  console.log(typeof completed);
  // error check 
  if (!req.body) {
      res.status(400).json({
          error: "You must provide a task to update"
      });
      return;
  }
  try {
  interface PatchDetails {
    title?: string;
    description?: string;
    hoursEstimated?: number;
    completed?: boolean;
    [key: string]: any;
  }

  const details: PatchDetails = {
    title,
    description,
    hoursEstimated,
    completed
  };
  console.log(details.completed);
  const update: PatchDetails = {};

  Object.keys(details).forEach(async (key: string) => {
    if (details[key] != null) {
      update[key] = details[key];
    }
  });

  const updatedTask = await taskData.updateTask(taskID, update);
  res.json(updatedTask);
  } catch (e) {
      console.log(e);
      res.status(500).json({
          error: e
      });
  }
});

router.post("/:id/comments", async (req: Request, res: Response): Promise<void> => {
    const taskID:string = req.params.id;
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
    const newComment = await taskData.addComment(taskID, commentInfo.name, commentInfo.comment);
    res.json(newComment);
  } catch (e) {
    console.log(e);
    res.status(500).json({
      error: e
    });
  }
});

// delete comment by id on task by id
router.delete("/:taskId/:commentId", async (req:Request, res: Response):Promise<void> => {
  const taskID: string = req.params.taskId;
  const commentID: string = req.params.commentId;
  //verify that task exists
  try {
      await taskData.getTaskById(taskID);
  } catch (e) {
      console.log(e);
      res.status(404).json({
          error: e
      });
      return;
  }

  //remove comment
  try {
      await taskData.removeComment(taskID, commentID);
      res.sendStatus(200);
  } catch (e) {
      console.log(e);
      res.status(500).json({
          error: e
      });
  }
});


module.exports = router;
