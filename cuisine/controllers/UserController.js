/**
 * Created by wangbochen on 9/23/15.
 */

var models  = require('../models');
var User = models.User;
var jwt  = require("jsonwebtoken");
var secret_key = "12809u9ash";

exports.ensureAuthorized = function (req, res, next) {
	var bearerToken = req.headers["authorization"];
	if (typeof bearerToken !== 'undefined') {
		req.token = bearerToken;
		next();
	} else {
		res.send(403);
	}
};

exports.findUserByToken = function (req,res){
  User.findOne({
      where:{
          token : req.token
      }
  }).then(function(user){
	  if(user) {
		  res.json({
			  type: true,
			  data: user
		  });
	  }
  })
};

exports.authenticate = function(req,res){
	User.findOne({
		where: {
			user_name: req.body.user_name,
			password: req.body.password
		}
	}).then(function(user) {
		if (user) {
			res.json({
				type: true,
				data: user
			});
		} else {
			res.status(401).json({
				type: false,
				data: "Incorrect username/password"
			});
		}
	});
};

exports.createUser = function (req,res){
    User.findOne({
        where: {
            user_name: req.body.user_name,
            password: req.body.password,
            email: req.body.email
        }
    }).then(function(user) {
        if (user) {
            res.status(409).json({
                type: false,
                data: "User already exists!"
            });
        } else{
            User.create({
                user_name: req.body.user_name,
                password: req.body.password,
                email: req.body.email
            }).then(function(user1){
                user1.token = jwt.sign(user1,secret_key);
                user1.save().then(function(user2){
                    res.json({
                        type:true,
                        data:user2
                    });
                });
            });
        }
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