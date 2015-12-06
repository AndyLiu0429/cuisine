/**
 * Created by wangbochen on 12/6/15.
 */
"use strict";

module.exports = function(sequelize, DataTypes) {
    var FavoriteDish =  sequelize.define('FavoriteDish', {
        user_id: {type:DataTypes.INTEGER},
        dish_id: {type:DataTypes.INTEGER}
    }, {
        classMethods: {
            associate: function (models) {
                // associations can be defined here

            }
        }
    });
    return FavoriteDish;
};