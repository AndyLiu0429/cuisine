/**
 * Created by wangbochen on 12/6/15.
 */
var models  = require('../models');
var Dish = models.Dish;
var User = models.User;
var util = require('./Utils');

var redis = require('redis');
var client = redis.createClient(); //creates a new client
client.on('connect', function() {
    //console.log('Redis Connected');
});

exports.saveDish = function (dish_name,json_str){
    if(dish_name.length&&json_str.length) {
        Dish.findOne({
            where: {
                dish_name: dish_name
            }
        }).then(function (dish) {
            if (dish) {
                console.log("Dish already exists!");
            } else {
                Dish.create({
                    dish_name: dish_name,
                    json_str: json_str
                }).then(function (dish1) {
                    dish1.save();
                });
            }
        });
    } else {
        console.log("Empty dish name or description!");
    }
};

exports.createFavorite = function (req,res){
    var user_id = req.body.user_id;
    var dish_name = req.body.dish_name;

    //console.log(req.body);
    var dish_counter = util.counterStr(dish_name);
    client.exists(dish_counter, function(err, rep) {

        if (rep === 1) {
            client.incr(dish_counter);
            console.log('reach here ');
        } else {
            client.set(dish_counter, 1);
        }
    });

    User.findOne({
        where:{
            id:user_id
        }
    }).then(function(user){
        if(!user) {
            res.status(401).json({
                type: false,
                data: "No existed UserID!"
            });
        }else{
            Dish.findOne({
                where:{
                    dish_name:dish_name
                }
            }).then(function(dish){
                if(!dish) {
                    res.status(401).json({
                        type: false,
                        data: "No existed Dish name!"
                    });
                }else{
                    user.addDish(dish);
                    res.status(200).json({
                        type: true,
                        data: "Successfully add favorites!"
                    });
                }
            });
        }
    });
};

exports.getFavorite = function(req,res){
    var user_id = req.query.user_id;
    User.findOne({
        where:{
            id:user_id
        }
    }).then(function (user) {
        if (!user) {
            res.status(401).json({
                type: false,
                data: "UserID not existed!"
            });

        } else {
            user.getDishes().then(function(dishes){
                if(!dishes){
                    res.status(401).json({
                        type: false,
                        data: "No favorite dishes!"
                    });
                }else{
                    res.status(200).json({
                        type:true,
                        data:dishes
                    });
                }
            });
        }
    });

};

