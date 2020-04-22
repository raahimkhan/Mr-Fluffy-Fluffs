const mongoose = require('mongoose');
const session  = require('express-session');
const Customer = require('../../src/models/Customer.model');

const login = (req,res) => {

  if(req.session.Email && req.session.PassHash)
  {
    Customer.findOne({Email:req.session.Email,PassHash:req.session.PassHash}, (err,customer) => {
      if(err) {
        //handle error
      }
      else {
        if(customer) {
          res.json({status:'True',msg:'Customer Already logged in.'});
        }
        else {
          req.session.destroy();
          res.json({status:'False',msg:'Credentials has been changed. Please log in agains.'});
        }
      }
    });
  }
  else {
    try {

      Customer.findOne({Email:req.body.customer.Email,PassHash:req.body.customer.PassHash}, (err,customer) => {
        if(err) {
          res.json({status:'False',msg:'Invalid Username or Password.'});
        }
        else {
          if(customer) {
            req.session.Email    = req.body.customer.Email;
            req.session.PassHash = req.body.customer.PassHash;
            res.json({status:'True',msg:'Customer logged in.'});
          }
          else {
            res.json({status:'False',msg:'Invalid Username or Password.'});
          }
        }
      });

    }
    catch(Error) {
      res.json({status:'False',msg:'Internal Server Error.'});
    }
  }



};

module.exports = login;
