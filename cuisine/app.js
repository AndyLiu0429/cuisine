var express = require('express');
var logger = require('morgan');
var bodyParser = require('body-parser');
var fs = require('fs');
var morgan = require('morgan');

var app = express();
// create a write stream (in append mode)
var accessLogStream = fs.createWriteStream(__dirname + '/access.log', {flags: 'a'});

app.use(morgan('combined', {stream: accessLogStream}));

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(function(req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type, Authorization');
  next();
});

var user = require('./controllers/UserController');
//app.get('/test',function(req,res){res.send("test");});
app.post('/user/',user.createUser);
app.post('/authenticate',user.authenticate);
app.get('/home', user.ensureAuthorized, user.findUserByToken);

var search = require('./controllers/search');
app.get('/search', search.redis_search , search.search_food_fuzzy);

var dish = require('./controllers/DishController');
app.post('/favorite',dish.createFavorite);
//app.post('/favorite/delete',dish.deleteFavorite);
app.get('/favorite',dish.getFavorite);

var mail = require('./controllers/MailController');
app.post('/mail',mail.sendEmail);


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;

