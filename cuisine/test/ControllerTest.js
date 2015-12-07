var dishcontroll = require('../controllers/DishController');
var models  = require('../models/index');
var User = models.User;
var Dish = models.Dish;

//dishcontroll.saveDish('roast beef','description');
//dishcontroll.saveDish('fried beef','description');
//dishcontroll.saveDish('zha beef','description');
//dishcontroll.saveDish('chao beef','description');
////
//User.create({
//
//        user_name: "wangbochen",
//        password: "123456"
//
//}).then(function(user){
//    user.save();
//});
//
//User.create({
//
//        user_name: "liutianyuan",
//        password: "123456"
//
//}).then(function(user){
//    user.save();
//});


User.findOne({
    where: {
        user_name: "wangbochen",
        password: "123456"
    }
}).then(function(user){
    Dish.findOne({
        where:{
            dish_name:"zha beef"
        }
    }).then(function(dish){
        user.addDish(dish);
    });

    Dish.findOne({
        where:{
            dish_name:"chao beef"
        }
    }).then(function(dish){
        user.addDish(dish);
    });
    //user.getDishes().then(function(dish){
    //    //dish.forEach(function(e){
    //    //    console.log(e.dataValues);
    //    //});
    //    console.log(dish);
    //});
});


