/**
 * Created by wangbochen on 9/22/15.
 */
"use strict";
var Sequelize = require('sequelize');
var fs        = require("fs");
var path      = require("path");
var config = require('../config').db_test;
var sequelize = new Sequelize(config.database,config.user,config.password,config);
var db        = {};
//console.log(config.db_addr);
fs
    .readdirSync(__dirname)
    .filter(function(file) {
        return (file.indexOf(".") !== 0) && (file !== "index.js");
    })
    .forEach(function(file) {
        var model = sequelize.import(path.join(__dirname, file));
        db[model.name] = model;
    });

Object.keys(db).forEach(function(modelName) {
    if ("associate" in db[modelName]) {
        db[modelName].associate(db);
    }
});

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;


