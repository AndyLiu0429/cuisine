/**
 * Created by wangbochen on 9/23/15.
 */

var express = require('express');
var router = express.Router();


router.get('/', function(req, res, next) {
    res.render('home', {});
});

module.exports = router;

