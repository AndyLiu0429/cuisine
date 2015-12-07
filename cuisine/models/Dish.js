/**
 * Created by wangbochen on 12/6/15.
 */
"use strict";

module.exports = function(sequelize, DataTypes) {
    var Dish = sequelize.define('Dish', {
        dish_name: {type:DataTypes.STRING,allowNull:false},
        json_str: {type:DataTypes.STRING(2000),allowNull:false}
    }, {
        classMethods: {
            associate: function (models) {
                // associations can be defined here
                Dish.hasMany(models.FavoriteDish,{
                    foreignKey: 'dish_id'
                });
            }
        }
    });
    return Dish;
};

