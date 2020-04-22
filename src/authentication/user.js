const session = require('express-session');
const mongoose = require('mongoose');
const Customer = require('../models/Customer.model');

const userAuth = (req,res,next) => {

  if(req.session.Email && req.session.PassHash) {
    Customer.findOne({Email:req.session.Email,PassHash:req.session.PassHash}, (err,customer) => {

      if(err) {
        req.session.destroy();
        res.json({status:'False',msg:'You must be logged in to access this feature.'});
      }
      else {
        if(customer) {
          next();
        }
        else {
          req.session.destroy();
          res.json({status:'False',msg:'You must be logged in to access this feature.'});
        }
      }

    });
  }
  else {
    res.json({status:'False', msg:'You must be logged in to access this feature.'});
    return;
  }

};

module.exports = userAuth;
