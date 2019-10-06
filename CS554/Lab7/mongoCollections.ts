/********
 * Name: Jennifer Cafiero
 * Date: May 5, 2019
 * CS554 Lab 7 - Lab 1 Revisited
 * mongoCollections.ts
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/
import { Collection } from 'mongodb';
import dbConnection from './mongoConnection';

export interface Task {
  _id: string;
  title: string;
  description: string;
  hoursEstimated: number;
  completed: boolean;
  comments: Comment[];
}

export interface Comment {
  _id: string;
  name: string;
  comment: string;
}

 function getCollectionFn<T>(collection : string): () => Promise<Collection<T>> {
  let _col: Collection<T> | undefined;

  return async () => {
    if (!_col) {
      const db = await dbConnection();
      _col = await db.collection<T>(collection);
    }
    return _col;
  };
};

const tasks = getCollectionFn<Task>("tasks");

export {tasks};
