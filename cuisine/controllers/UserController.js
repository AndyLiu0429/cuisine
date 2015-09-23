/**
 * Created by wangbochen on 9/23/15.
 */
var app = require('./app');
var User = app.get('models').User;
User.build({first_name:'Jane',last_name:'Doe'});
