/**
 * Created by wangbochen on 9/23/15.
 */
"use strict";

module.exports = function(sequelize, DataTypes) {
    var User = sequelize.define('User', {
        user_name: {type:DataTypes.STRING,allowNull:false},
        password: {type:DataTypes.STRING,allowNull:false},
        email: {type:DataTypes.STRING,allowNull:false},
        token:{type:DataTypes.STRING(500)}
    }, {
        classMethods: {
           associate: function (models) {
                //associations can be defined here
                User.belongsToMany(models.Dish,{
                    through: 'FavoriteDishes',
                    onDelete : 'cascade'
                });
            }
        }
    }
    );
    return User;
};