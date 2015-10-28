/**
 * Created by liutianyuan on 10/25/15.
 */

var yelp_config = require("../config").yelp;
var async = require("async");
var yelp = require("yelp").createClient({
    consumer_key: yelp_config.consumer_key,
    consumer_secret: yelp_config.consumer_secret,
    token: yelp_config.token,
    token_secret: yelp_config.token_secret
});

exports.search_food = function(req, res) {
    var term = req.body.term;

    if (term === "") {
        res.send(403);
    }

    var result = [];
    yelp.search({term: term, limit: "10", location: "Manhattan"}, function(error, data) {
        if (error) {

        }

        for (var i = 0; i < data.businesses.length; i++) {
            var now = {
                'image_url' : data.businesses[i].image_url,
                'restaurant_name' : data.businesses[i].name,
                'desc' : data.businesses[i].snippet_text,
                'category': mergeTitle(data.businesses[i].categories)
            };
            res.push(now);
        }


    });

    res.json({"result" : result});
};

var mergeTitle = function(titles) {
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


exports.search_food_fuzzy = function(req, res) {
    var term = req.body.term;

    if (term === "") {
        res.send(403);
    }

    yummly.search({
            credentials: credentials,
            query: {
                q: term
            }
        }, function (error, response, json) {
            if (error) {
                console.error(error);
            } else if (response === 200) {
                var res = json['matches'];

                async.map(res,function(e, callback) {

                        var now = {
                            'name' : e.recipeName,
                            'image_url' : e.smallImageUrls[0]
                        };

                        yelp.search({term: e.recipeName, limit: "1", location: "Manhattan"}, function (err, data) {
                            if (err) {
                                console.log(err);
                            } else {

                                now['restaurant_name'] = data.businesses[0].name;
                                now['desc'] = data.businesses[0].snippet_text;
                                now['category'] = mergeTitle(data.businesses[0].categories);

                            }
                            callback(null, now);
                        });
                    },function(err, results){
                        res.json({"result" : results});
                    }
                );

            }
        }

    );



};

