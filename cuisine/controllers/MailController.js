var mailer = require("nodemailer");
var smtpTransport = require('nodemailer-smtp-transport');

exports.sendEmail = function(req,res){
    var transport = mailer.createTransport((smtpTransport({
        service:'gmail',
        auth: {
            user: 'cs5356.cuisine@gmail.com',
            pass: 'liutianyuan'
        }
    })));
    var mailOptions={
        to : req.body.to,
        subject : req.body.subject,
        text : req.body.text
    };
    //console.log(mailOptions);
    transport.sendMail(mailOptions, function(error, response){
        if(error){
            // console.log(error);
            res.json({
                type:false,
                data:'Fail to send email.'
            });
        }else{
            // console.log("Message sent: " + response.message);
            res.json({
                type:true,
                data:'Successfully send email.'
            });
        }
    });
};