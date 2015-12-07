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


var dishcontroll = require('../controllers/DishController');
var app = require('../app');
var models  = require('../models');
models.sequelize.sync({force: false});

var User = models.User;
var port = 3333;


describe('app', function() {
    var url = 'http://localhost:'  + port;
    var token;
    var user_id;


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

                dishcontroll.saveDish('xiaohaha',  'dad12');
                dishcontroll.saveDish('beef', 'dadadac');
                dishcontroll.saveDish('pasta', 'haah');

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
            .post('/user')
            .send(profile)
            .end(function(err, res) {
                if (err) {
                    throw err;
                }

                res.status.should.be.equal(200);
                token = res.body.data.token;
                user_id = res.body.data.id;
                console.log(user_id);

                //console.log(token);
                done();
            })

    });

    it('should not create user if exist', function(done) {
        request(url)
            .post('/user')
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
            .get('/home')
            .set('Accept', 'application/json')
            .set('Authorization', token)
            .end(function(err, res) {
                if (err) {
                    throw err;
                }
                //console.log(res);
                res.status.should.be.equal(200);
                done();
            })

    });

    it ('should return some results if search something', function(done) {
        request(url)
            .get('/search?term=beef')
            .set('Authorization', token)
            .end(function(err, res) {
                if (err) {
                    throw err;
                }

                //console.log(res);
                res.status.should.be.equal(200);
                done();
            })
    });

    it ('should create favorite dish lists with valid user id', function(done) {
        request(url)
            .post('/favorite')
            .send({
                user_id : user_id,
                dish_name : 'xiaohaha'
            })
            .end(function(err, res) {
                if (err) {
                    throw err;
                }

                //console.log(res);
                res.status.should.be.equal(200);
                done();
            })

    });



    it ('should not return anything when query is invalid', function(done) {
        request(url)
            .post('/favorite')
            .send({
                user_id : user_id,
                dish_name : 'beefnogood'
            })
            .end(function(err, res) {
                if (err) {
                    throw err;
                }

                res.status.should.be.equal(401);
                done();
            })
    })

    it ('should return whole favorite dish lists when query with valid user id', function(done) {
        request(url)
            .get('/favorite?user_id=' + user_id)
            .end(function(err, res) {
                if (err) {
                    throw err;
                }
                //console.log(res);
                res.status.should.be.equal(200);
                done();
            })
    });

    it ('should return nothing if query with wrong user id', function(done) {
        request(url)
            .get('/favorite?user_id=42')
            .end(function(err, res) {
                if (err) {
                    throw err;
                }

                res.status.should.be.equal(401);
                done();
            })

    })

});
