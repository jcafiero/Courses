import { Task, Comment, tasks} from '../../mongoCollections';
import {v4} from 'uuid';
import { BulkWriteOpResultObject } from 'mongodb';

export default {
  getAllTasks: async function(): Promise<Task[]> {
    const taskCollection = await tasks();
    return taskCollection.find({}).project({
      "_id": 0
    }).toArray();
  },

  getTaskById: async function(id: string) {
    if (!id) throw "Error: must provide an id";
    if (typeof id !== "string") throw "Error: id must be a string";

    const taskCollection = await tasks();
    const foundTask = await taskCollection.findOne({
      _id: id
    });
    
    if (!foundTask) throw "Error: task not found";
    return foundTask;
  },

  addTask: async function(title: string, description: string, hoursEstimated: number) {

    if (!title) throw "Error: must provide a title";
    if (!description) throw "Error: must provide a description";
    if (!hoursEstimated) throw "Error: must provide a time estimate";
    if (typeof title !== "string") throw "Error: title must be a string";
    if (typeof description !== "string") throw "Error: description must be a string";
    if (typeof hoursEstimated !== "number") throw "Error: hoursEstimated must be a number";
    
    const taskCollection = await tasks();
    let newTask: Task = {
      _id: v4(),
      title: title,
      description: description,
      hoursEstimated: hoursEstimated,
      completed: false,
      comments: [] as Comment[]
    };
    const insertTask = await taskCollection.insertOne(newTask);
    if (insertTask.insertedCount === 0) throw "Error: could not insert task";
    return await this.getTaskById(newTask._id);
  },

  //Why did i write this function when we didn't need to remove a task ='(
  // removeTask: async function(id) {
  //   if (!id) throw "Error: must provide an id";
  //   if (typeof id !== "string") throw "Error: id must be a string";

  //   const taskCollection = await tasks();

  //   const deletionInfo = await taskCollection.removeOne({
  //     id: id
  //   });

  //   if (deletionInfo.deletedCount === 0) throw `Error: could not remove task with id ${id}`;

  //   return true;
  // },

  updateTask: async function(id: string, updatedTask: {
      title?: string,
      description?: string,
      hoursEstimated?: number,
      completed?: boolean
    }) {
    // if (!id) throw "Error: must provide an id";
    // if (typeof id !== "string") throw "Error: id must be a string";
    // if (!updatedTask) throw "Error: must provide a task";
    // if (typeof updatedTask !== "object") throw "Error: task must be an object";
    // // if (!updatedTask.title) throw "Error: must provide a title";
    // // if (!updatedTask.description) throw "Error: must provide a description";
    // // if (!updatedTask.hoursEstimated) throw "Error: must provide a time estimate";
    // // if (!updatedTask.completed) throw "Error: must provide if completed";
    // if (updatedTask.title && typeof updatedTask.title !== "string") throw "Error: title must be a string";
    // if (updatedTask.description && typeof updatedTask.description !== "string") throw "Error: description must be a string";
    // if (updatedTask.hoursEstimated && typeof updatedTask.hoursEstimated !== "number") throw "Error: hoursEstimated must be a number";
    // if (typeof updatedTask.completed !== "boolean") throw "Error: completed must be a boolean"; 
    const taskCollection = await tasks();

    let existingTask = await taskCollection.findOne({_id : id});
    if (existingTask) {
      let { completed, comments } = existingTask;
      // let taskUpdateInfo = {
      //   title: updatedTask.title ? updatedTask.title : existingTask.title,
      //   description: updatedTask.description ? updatedTask.description : existingTask.description,
      //   hoursEstimated: updatedTask.hoursEstimated ? updatedTask.hoursEstimated : existingTask.hoursEstimated,
      //   completed: updatedTask.completed ? updatedTask.completed : existingTask.completed
      // };
      

      await taskCollection.updateOne({
        _id: id
      }, {
        $set: { ...updatedTask, comments}
      });
      return taskCollection.findOne({ _id: id})
    } else {
      throw "cannot update task that does not exist"
    }
  },
  addComment: async function(taskId: string, name: string, comment: string): Promise<void> {
    if (!taskId) throw "Error: must provide a id";
    if (!name) throw "Error: must provide a name";
    if (!comment) throw "Error: must provide a comment";
    if (typeof taskId !== "string") throw "Error: id must be a string";
    if (typeof name !== "string") throw "Error: name must be a string";
    if (typeof comment !== "string") throw "Error: comment must be a string";

    let newComment: Comment = {
      _id: v4(),
      name: name,
      comment: comment
    };
    
    const taskCollection = await tasks();

    //make sure that the task is in the collection before proceeding
    let task = await this.getTaskById(taskId);

    //push new comments to a list as opposed to above where we updated task info with $set (to overwrite existing)
    const insertComment = await taskCollection.updateOne({_id : taskId}, {$push: { comments: newComment}});
    // if (insertComment.insertedCount === 0) throw "Error: could not insert comment";

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
      _id: taskId
    }, { $pull: { comments: { _id: commentId } } });

    // if (deletionInfo.deletedCount === 0) throw `Error: could not remove comment with id ${commentId}`;

    return await this.getTaskById(taskId);

  }
}
