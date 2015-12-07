/**
 * Created by wangbochen on 12/6/15.
 */
"use strict";

module.exports = function(sequelize, DataTypes) {
    var FavoriteDish =  sequelize.define('FavoriteDish', {
        status: DataTypes.STRING
    });
    return FavoriteDish;
};