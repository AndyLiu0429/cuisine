/**
 * Created by wangbochen on 9/23/15.
 */
var models  = require('../models');
var User = models.User;

exports.findUserByID = function (req,res){
  User.findOne({
      where:{
          id : req.params.id
      }
  }).then(function(user){
      res.send(user);
  })
};
exports.createUser = function (req,res){
    User.create({
        user_name : req.body.user_name,
        password : req.body.password,
        email : req.body.email
    }).then(function(user){
        res.send(user);
    });
};
exports.deleteUser = function (req,res){
    User.destroy({
        where:{
            id : req.params.id
        }
    }).then(function(){
        res.send("User deleted");
    });
};
exports.updateUserEmail = function (req,res){
    User.update(
    {
        email:req.body.email
    },
    {
        where:{id:req.params.id}
    }
    ).then(function(){
      res.send("User updated");
    });
};