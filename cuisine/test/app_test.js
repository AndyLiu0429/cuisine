/**
 * Created by liutianyuan on 9/30/15.
 */
/**
 * Created by wangbochen on 9/23/15.
 */
//models = require('../models');
//models.User.create({
//    user_name:"wangbochen",
//    password:"123456",
//    email:"wbcustc@mail.ustc.edu.cn"
//});

var assert = require("assert");
var request = require('supertest');
var should = require('should');

var app = require('../app');
var models  = require('../models');
var User = models.User;
var port = 3333;


describe('app', function() {
    var url = 'http://localhost:'  + port;
    var token;

    var profile = {
        'user_name' : "Wahaha",
        'password' : 'fuck',
        'email' : 'dada@gmail.com'
    };

    var server;

    before(function(done) {
        server = app.listen(port, function(err, result) {
            if (err) {
                done(err);
            } else {
                done();
            }
        })

    });

    after(function(done) {
        User.destroy({
            where : {
                user_name : profile.user_name
            }
        });

        server.close();
        done();
    });


    it('should create user if not exist', function(done) {
        request(url)
            .post('/user/create')
            .send(profile)
            .end(function(err, res) {
                if (err) {
                    throw err;
                }

                res.status.should.be.equal(200);
                token = res.body.data.token;
                done();
            })

    });

    it('should not create user if exist', function(done) {
        request(url)
            .post('/user/create')
            .send(profile)
            .end(function(err, res) {
                if (err) {
                    throw err;
                }
                res.status.should.be.equal(409);
                done();
            })
    });

    it ('should be authenticated if user exist', function(done) {
        request(url)
            .post('/authenticate')
            .send({
                user_name : profile.user_name,
                password : profile.password
            })
            .end(function(err, res) {
                if (err) {
                    throw err;
                }

                res.status.should.be.equal(200);
                done();
            })

    });

    it ('should not be authenticated if user not exist', function(done) {
        request(url)
            .post('/authenticate')
            .field('user_name', 'Wahaha')
            .field('password', 'fucke')
            .end(function(err, res) {
                if (err) {
                    throw err;
                }

                res.status.should.be.equal(401);
                done();
            })

    });

    it ('should see my homepage if authenticated', function(done) {
        request(url)
            .get('/me')
            .set('authorization', token)
            .end(function(err, res) {
                if (err) {
                    throw err;
                }

                res.status.should.be.equal(200);
                done();
            })

    });


});