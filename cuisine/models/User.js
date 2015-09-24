/**
 * Created by wangbochen on 9/23/15.
 */
"use strict";

module.exports = function(sequelize, DataTypes) {
    return sequelize.define('User', {
        first_name: {type:DataTypes.STRING},
        last_name: {type:DataTypes.STRING},
        user_name: {type:DataTypes.STRING,allowNull:false},
        email: {type:DataTypes.STRING,allowNull:false},
        password: {type:DataTypes.STRING,allowNull:false}
    }, {
        classMethods: {
            associate: function (models) {
                // associations can be defined here
            }
        }
    });
};