"use strict";
/********
 * Name: Jennifer Cafiero
 * Date: May 5, 2019
 * CS554 Lab 7 - Lab 1 Revisited
 * recipes.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/
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
var _this = this;
exports.__esModule = true;
var express = require("express");
var router = express.Router();
var data = require("../data");
var taskData = data.tasks;
//function to validate request body input
function checkRequestBody(params) {
    var title = params.title, description = params.description, hoursEstimated = params.hoursEstimated, completed = params.completed;
    return (!!title && typeof title === "string" &&
        !!description && typeof description === "string" &&
        typeof hoursEstimated === "number" && hoursEstimated > 0 &&
        (typeof completed === "boolean" || completed === undefined));
}
//get all tasks
router.get("/", function (req, res) { return __awaiter(_this, void 0, void 0, function () {
    var skip, take, taskList, e_1;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                _a.trys.push([0, 2, , 3]);
                skip = 0;
                take = 20;
                if (req.query.skip) {
                    skip = parseInt(req.query.skip);
                    if (isNaN(skip))
                        throw "Error: querystring variable skip should be a number";
                }
                if (req.query.take) {
                    take = parseInt(req.query.take);
                    if (isNaN(take))
                        throw "Error: querystring variable take should be a number";
                    if (take > 100)
                        take = 100;
                }
                return [4 /*yield*/, taskData.getAllTasks()];
            case 1:
                taskList = _a.sent();
                res.json(taskList.slice(skip).slice(0, take));
                return [3 /*break*/, 3];
            case 2:
                e_1 = _a.sent();
                console.log(e_1);
                res.status(500).json({
                    error: e_1
                });
                return [3 /*break*/, 3];
            case 3: return [2 /*return*/];
        }
    });
}); });
//get single task by id
router.get("/:id", function (req, res) { return __awaiter(_this, void 0, void 0, function () {
    var taskID, task, e_2;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                taskID = req.params.id;
                _a.label = 1;
            case 1:
                _a.trys.push([1, 3, , 4]);
                return [4 /*yield*/, taskData.getTaskById(taskID)];
            case 2:
                task = _a.sent();
                res.json(task);
                return [3 /*break*/, 4];
            case 3:
                e_2 = _a.sent();
                console.log(e_2);
                res.status(404).json({
                    error: e_2
                });
                return [3 /*break*/, 4];
            case 4: return [2 /*return*/];
        }
    });
}); });
//post new task
router.post("/", function (req, res) { return __awaiter(_this, void 0, void 0, function () {
    var _a, title, description, hoursEstimated, newTask, e_3;
    return __generator(this, function (_b) {
        switch (_b.label) {
            case 0:
                _a = req.body, title = _a.title, description = _a.description, hoursEstimated = _a.hoursEstimated;
                if (!title && !description && !hoursEstimated) {
                    res.status(400).json({
                        error: "You must provide a task"
                    });
                    return [2 /*return*/];
                }
                if (!title) {
                    res.status(400).json({
                        error: "You must provide a task title"
                    });
                    return [2 /*return*/];
                }
                if (!description) {
                    res.status(400).json({
                        error: "You must provide a task description"
                    });
                    return [2 /*return*/];
                }
                if (!hoursEstimated) {
                    res.status(400).json({
                        error: "You must provide a time estimate for the task"
                    });
                    return [2 /*return*/];
                }
                _b.label = 1;
            case 1:
                _b.trys.push([1, 3, , 4]);
                return [4 /*yield*/, taskData.addTask(title, description, hoursEstimated)];
            case 2:
                newTask = _b.sent();
                res.json(newTask);
                return [3 /*break*/, 4];
            case 3:
                e_3 = _b.sent();
                console.log(e_3);
                res.status(500).json({
                    error: e_3
                });
                return [3 /*break*/, 4];
            case 4: return [2 /*return*/];
        }
    });
}); });
//update the whole task
router.put("/:id", function (req, res) { return __awaiter(_this, void 0, void 0, function () {
    var taskID, _a, title, description, hoursEstimated, completed, e_4, taskInfo, e_5;
    return __generator(this, function (_b) {
        switch (_b.label) {
            case 0:
                taskID = req.params.id;
                _a = req.body, title = _a.title, description = _a.description, hoursEstimated = _a.hoursEstimated, completed = _a.completed;
                if (!req.body) {
                    res.status(400).json({
                        error: "You must provide a task to update"
                    });
                    return [2 /*return*/];
                }
                if (!title) {
                    res.status(400).json({
                        error: "You must provide a task title"
                    });
                    return [2 /*return*/];
                }
                if (!description) {
                    res.status(400).json({
                        error: "You must provide task description"
                    });
                    return [2 /*return*/];
                }
                if (!hoursEstimated) {
                    res.status(400).json({
                        error: "You must provide hours estimated"
                    });
                    return [2 /*return*/];
                }
                if (completed == null) {
                    res.status(400).json({
                        error: "You must provide if completed"
                    });
                    return [2 /*return*/];
                }
                _b.label = 1;
            case 1:
                _b.trys.push([1, 3, , 4]);
                return [4 /*yield*/, taskData.getTaskById(taskID)];
            case 2:
                _b.sent();
                return [3 /*break*/, 4];
            case 3:
                e_4 = _b.sent();
                console.log(e_4);
                res.status(404).json({
                    error: e_4
                });
                return [2 /*return*/];
            case 4:
                _b.trys.push([4, 6, , 7]);
                return [4 /*yield*/, taskData.updateTask(taskID, {
                        title: title,
                        description: description,
                        hoursEstimated: hoursEstimated,
                        completed: completed === true
                    })];
            case 5:
                taskInfo = _b.sent();
                res.json(taskInfo);
                return [3 /*break*/, 7];
            case 6:
                e_5 = _b.sent();
                console.log(e_5);
                res.status(500).json({
                    error: e_5
                });
                return [3 /*break*/, 7];
            case 7: return [2 /*return*/];
        }
    });
}); });
//update task only with included values
router.patch("/:id", function (req, res) { return __awaiter(_this, void 0, void 0, function () {
    var taskID, _a, title, description, hoursEstimated, completed, details_1, update_1, updatedTask, e_6;
    var _this = this;
    return __generator(this, function (_b) {
        switch (_b.label) {
            case 0:
                taskID = req.params.id;
                _a = req.body, title = _a.title, description = _a.description, hoursEstimated = _a.hoursEstimated, completed = _a.completed;
                console.log(completed);
                console.log(typeof completed);
                // error check 
                if (!req.body) {
                    res.status(400).json({
                        error: "You must provide a task to update"
                    });
                    return [2 /*return*/];
                }
                _b.label = 1;
            case 1:
                _b.trys.push([1, 3, , 4]);
                details_1 = {
                    title: title,
                    description: description,
                    hoursEstimated: hoursEstimated,
                    completed: completed
                };
                console.log(details_1.completed);
                update_1 = {};
                Object.keys(details_1).forEach(function (key) { return __awaiter(_this, void 0, void 0, function () {
                    return __generator(this, function (_a) {
                        if (details_1[key] != null) {
                            update_1[key] = details_1[key];
                        }
                        return [2 /*return*/];
                    });
                }); });
                return [4 /*yield*/, taskData.updateTask(taskID, update_1)];
            case 2:
                updatedTask = _b.sent();
                res.json(updatedTask);
                return [3 /*break*/, 4];
            case 3:
                e_6 = _b.sent();
                console.log(e_6);
                res.status(500).json({
                    error: e_6
                });
                return [3 /*break*/, 4];
            case 4: return [2 /*return*/];
        }
    });
}); });
router.post("/:id/comments", function (req, res) { return __awaiter(_this, void 0, void 0, function () {
    var taskID, commentInfo, newComment, e_7;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                taskID = req.params.id;
                commentInfo = req.body;
                if (!commentInfo) {
                    res.status(400).json({
                        error: "You must provide a comment"
                    });
                    return [2 /*return*/];
                }
                if (!commentInfo.name) {
                    res.status(400).json({
                        error: "You must provide a comment name"
                    });
                    return [2 /*return*/];
                }
                if (!commentInfo.comment) {
                    res.status(400).json({
                        error: "You must provide a comment body"
                    });
                    return [2 /*return*/];
                }
                _a.label = 1;
            case 1:
                _a.trys.push([1, 3, , 4]);
                return [4 /*yield*/, taskData.addComment(taskID, commentInfo.name, commentInfo.comment)];
            case 2:
                newComment = _a.sent();
                res.json(newComment);
                return [3 /*break*/, 4];
            case 3:
                e_7 = _a.sent();
                console.log(e_7);
                res.status(500).json({
                    error: e_7
                });
                return [3 /*break*/, 4];
            case 4: return [2 /*return*/];
        }
    });
}); });
// delete comment by id on task by id
router["delete"]("/:taskId/:commentId", function (req, res) { return __awaiter(_this, void 0, void 0, function () {
    var taskID, commentID, e_8, e_9;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                taskID = req.params.taskId;
                commentID = req.params.commentId;
                _a.label = 1;
            case 1:
                _a.trys.push([1, 3, , 4]);
                return [4 /*yield*/, taskData.getTaskById(taskID)];
            case 2:
                _a.sent();
                return [3 /*break*/, 4];
            case 3:
                e_8 = _a.sent();
                console.log(e_8);
                res.status(404).json({
                    error: e_8
                });
                return [2 /*return*/];
            case 4:
                _a.trys.push([4, 6, , 7]);
                return [4 /*yield*/, taskData.removeComment(taskID, commentID)];
            case 5:
                _a.sent();
                res.sendStatus(200);
                return [3 /*break*/, 7];
            case 6:
                e_9 = _a.sent();
                console.log(e_9);
                res.status(500).json({
                    error: e_9
                });
                return [3 /*break*/, 7];
            case 7: return [2 /*return*/];
        }
    });
}); });
module.exports = router;
