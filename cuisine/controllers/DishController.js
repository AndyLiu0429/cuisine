/**
 * Created by wangbochen on 12/6/15.
 */
var models  = require('../models');
var Dish = models.Dish;

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

Dish.us