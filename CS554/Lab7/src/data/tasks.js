"use strict";
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
exports.__esModule = true;
var mongoCollections_1 = require("../../mongoCollections");
var uuid_1 = require("uuid");
exports["default"] = {
    getAllTasks: function () {
        return __awaiter(this, void 0, void 0, function () {
            var taskCollection;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, mongoCollections_1.tasks()];
                    case 1:
                        taskCollection = _a.sent();
                        return [2 /*return*/, taskCollection.find({}).project({
                                "_id": 0
                            }).toArray()];
                }
            });
        });
    },
    getTaskById: function (id) {
        return __awaiter(this, void 0, void 0, function () {
            var taskCollection, foundTask;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (!id)
                            throw "Error: must provide an id";
                        if (typeof id !== "string")
                            throw "Error: id must be a string";
                        return [4 /*yield*/, mongoCollections_1.tasks()];
                    case 1:
                        taskCollection = _a.sent();
                        return [4 /*yield*/, taskCollection.findOne({
                                _id: id
                            })];
                    case 2:
                        foundTask = _a.sent();
                        if (!foundTask)
                            throw "Error: task not found";
                        return [2 /*return*/, foundTask];
                }
            });
        });
    },
    addTask: function (title, description, hoursEstimated) {
        return __awaiter(this, void 0, void 0, function () {
            var taskCollection, newTask, insertTask;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (!title)
                            throw "Error: must provide a title";
                        if (!description)
                            throw "Error: must provide a description";
                        if (!hoursEstimated)
                            throw "Error: must provide a time estimate";
                        if (typeof title !== "string")
                            throw "Error: title must be a string";
                        if (typeof description !== "string")
                            throw "Error: description must be a string";
                        if (typeof hoursEstimated !== "number")
                            throw "Error: hoursEstimated must be a number";
                        return [4 /*yield*/, mongoCollections_1.tasks()];
                    case 1:
                        taskCollection = _a.sent();
                        newTask = {
                            _id: uuid_1.v4(),
                            title: title,
                            description: description,
                            hoursEstimated: hoursEstimated,
                            completed: false,
                            comments: []
                        };
                        return [4 /*yield*/, taskCollection.insertOne(newTask)];
                    case 2:
                        insertTask = _a.sent();
                        if (insertTask.insertedCount === 0)
                            throw "Error: could not insert task";
                        return [4 /*yield*/, this.getTaskById(newTask._id)];
                    case 3: return [2 /*return*/, _a.sent()];
                }
            });
        });
    },
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
    updateTask: function (id, updatedTask) {
        return __awaiter(this, void 0, void 0, function () {
            var taskCollection, existingTask, completed, comments;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, mongoCollections_1.tasks()];
                    case 1:
                        taskCollection = _a.sent();
                        return [4 /*yield*/, taskCollection.findOne({ _id: id })];
                    case 2:
                        existingTask = _a.sent();
                        if (!existingTask) return [3 /*break*/, 4];
                        completed = existingTask.completed, comments = existingTask.comments;
                        // let taskUpdateInfo = {
                        //   title: updatedTask.title ? updatedTask.title : existingTask.title,
                        //   description: updatedTask.description ? updatedTask.description : existingTask.description,
                        //   hoursEstimated: updatedTask.hoursEstimated ? updatedTask.hoursEstimated : existingTask.hoursEstimated,
                        //   completed: updatedTask.completed ? updatedTask.completed : existingTask.completed
                        // };
                        return [4 /*yield*/, taskCollection.updateOne({
                                _id: id
                            }, {
                                $set: __assign({}, updatedTask, { comments: comments })
                            })];
                    case 3:
                        // let taskUpdateInfo = {
                        //   title: updatedTask.title ? updatedTask.title : existingTask.title,
                        //   description: updatedTask.description ? updatedTask.description : existingTask.description,
                        //   hoursEstimated: updatedTask.hoursEstimated ? updatedTask.hoursEstimated : existingTask.hoursEstimated,
                        //   completed: updatedTask.completed ? updatedTask.completed : existingTask.completed
                        // };
                        _a.sent();
                        return [2 /*return*/, taskCollection.findOne({ _id: id })];
                    case 4: throw "cannot update task that does not exist";
                }
            });
        });
    },
    addComment: function (taskId, name, comment) {
        return __awaiter(this, void 0, void 0, function () {
            var newComment, taskCollection, task, insertComment;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (!taskId)
                            throw "Error: must provide a id";
                        if (!name)
                            throw "Error: must provide a name";
                        if (!comment)
                            throw "Error: must provide a comment";
                        if (typeof taskId !== "string")
                            throw "Error: id must be a string";
                        if (typeof name !== "string")
                            throw "Error: name must be a string";
                        if (typeof comment !== "string")
                            throw "Error: comment must be a string";
                        newComment = {
                            _id: uuid_1.v4(),
                            name: name,
                            comment: comment
                        };
                        return [4 /*yield*/, mongoCollections_1.tasks()];
                    case 1:
                        taskCollection = _a.sent();
                        return [4 /*yield*/, this.getTaskById(taskId)];
                    case 2:
                        task = _a.sent();
                        return [4 /*yield*/, taskCollection.updateOne({ _id: taskId }, { $push: { comments: newComment } })];
                    case 3:
                        insertComment = _a.sent();
                        return [4 /*yield*/, this.getTaskById(taskId)];
                    case 4: 
                    // if (insertComment.insertedCount === 0) throw "Error: could not insert comment";
                    return [2 /*return*/, _a.sent()];
                }
            });
        });
    },
    removeComment: function (taskId, commentId) {
        return __awaiter(this, void 0, void 0, function () {
            var taskCollection, deletionInfo;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        if (!taskId)
                            throw "Error: must provide a task id";
                        if (!commentId)
                            throw "Error: must provide a comment id";
                        if (typeof taskId !== "string")
                            throw "Error: task id must be a string";
                        if (typeof commentId !== "string")
                            throw "Error: comment id must be a string";
                        return [4 /*yield*/, mongoCollections_1.tasks()];
                    case 1:
                        taskCollection = _a.sent();
                        return [4 /*yield*/, this.getTaskById(taskId)];
                    case 2:
                        _a.sent();
                        return [4 /*yield*/, taskCollection.updateOne({
                                _id: taskId
                            }, { $pull: { comments: { _id: commentId } } })];
                    case 3:
                        deletionInfo = _a.sent();
                        return [4 /*yield*/, this.getTaskById(taskId)];
                    case 4: 
                    // if (deletionInfo.deletedCount === 0) throw `Error: could not remove comment with id ${commentId}`;
                    return [2 /*return*/, _a.sent()];
                }
            });
        });
    }
};
