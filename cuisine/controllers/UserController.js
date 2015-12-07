/**
 * Created by wangbochen on 9/23/15.
 */

var models  = require('../models');
var User = models.User;
var jwt  = require("jsonwebtoken");
var secret_key = "128oas1309uana9cj02109u9ash";

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
		  res.status(200).json({
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
			res.status(200).json({
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
    var uname = req.body.user_name;
    var pswd = req.body.password;
    if(uname.length&&pswd.length) {
        User.findOne({
            where: {
                user_name: uname,
                password: pswd
            }
        }).then(function (user) {
            if (user) {
                res.status(409).json({
                    type: false,
                    data: "Username already exists!"
                });
            } else {
                User.create({
                    user_name: uname,
                    password: pswd
                }).then(function (user1) {
                    user1.token = jwt.sign(user1, secret_key);
                    user1.save().then(function () {
                        res.status(200).json({
                            type: true,
                            data: user1
                        });
                    });
                });
            }
        });
    } else {
        res.status(409).json({
            type: false,
            data: "Empty username or password!"
        });
    }
};


