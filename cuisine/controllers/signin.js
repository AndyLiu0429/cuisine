
/* GET home page. */
exports.show = function(req, res, next) {
	res.render('index', { title: 'Cuisine' });
};

