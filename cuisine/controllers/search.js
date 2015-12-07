/**
 * Created by liutianyuan on 10/25/15.
 */
var dish = require('./DishController');
var yelp_config = require("../config").yelp;
var async = require("async");
var yelp = require("yelp").createClient({
    consumer_key: yelp_config.consumer_key,
    consumer_secret: yelp_config.consumer_secret,
    token: yelp_config.token,
    token_secret: yelp_config.token_secret
});

exports.search_food = function(req, res) {
    var term = req.query.term;
    if (!term) {
        res.send(403);
    }

    var result = [];
    yelp.search({term: term, limit: "10", location: "Manhattan"}, function(error, data) {
        if (error) {
            console.log(error);
        }

        for (var i = 0; i < data.businesses.length; i++) {
            var now = {
                'image_url' : data.businesses[i].image_url,
                'restaurant_name' : data.businesses[i].name,
                'desc' : data.businesses[i].snippet_text,
                'category': mergeTitle(data.businesses[i].categories),
                'rating': data.businesses[i].rating
            };
            res.push(now);
        }

    });

    res.json({"result" : result});
};

var mergeTitle = function(titles) {
    if (!titles) return "";
    var res = titles.map(function(data) {
        return data[0];
    });
    return res.join(" ");
};


var credentials = {
    id: 'd5879cdd',
    key: '195d2edf037e06887f2a7bef5afa8dec'
};

var yummly = require('yummly');


exports.search_food_fuzzy = function(req, res, next) {
    var term = req.query.term;
    console.log(term);
    if (!term) {
        res.send(403);
    }
    else {
        yummly.search({
                credentials: credentials,
                query: {
                    q: term
                }
            }, function (error, response, json) {
                if (error) {
                    console.error(error);
                } else if (response === 200) {
                    var res1 = json['matches'];

                    async.map(res1, function (e, callback) {

                            var now = {
                                'name': e.recipeName,
                                'image_url': e['imageUrlsBySize']['90']
                            };

                            yelp.search({term: e.recipeName, limit: "1", location: "Manhattan"}, function (err, data) {
                                if (err) {
                                    console.log(err);
                                } else {
                                        //console.log(data);
                                        now['restaurant_name'] = data.businesses[0] ? data.businesses[0].name : "";
                                        now['desc'] = data.businesses[0] ? data.businesses[0].snippet_text : "";
                                        now['category'] = data.businesses[0] ? mergeTitle(data.businesses[0].categories) :
                                        "";
                                        dish.saveDish(now['name'], now);
                                }

                                callback(null, now);
                            });
                        }, function (err, results) {
                            var ret = {"result": results};
                            client.set(term,JSON.stringify(ret));

                            res.setHeader('Content-Type','application/json');
                            res.json(ret);
                        }
                    );

                }
            }
        );
    }
};

var redis = require('redis');
var client = redis.createClient(); //creates a new client
client.on('connect', function() {
    console.log('Redis Connected');
});

exports.redis_search = function(req,res,next){
    var key = req.query.term;
    //client.set(key,"mark");
    console.log(key);
    client.get(key,function(err,reply) {
        //console.log(reply);
        if(err){
            console.log(err);
        }else{
            if(reply){
                console.log(reply);
                res.setHeader('Content-Type','application/json');
                res.send(reply);
            }else{
                next();
            }
        }
    });
};

