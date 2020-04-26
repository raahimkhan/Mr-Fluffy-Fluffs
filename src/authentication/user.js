const mongoose = require('mongoose');
const utility = require('../Utility');
const Customer = require('../models/Customer.model');

const userAuth = (req,res,next) => {

    if((req.session.Username || req.session.Email) && req.session.PassHash)
    {
      let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash}

      utility.getOne(Customer,credentials)
      .then(customer => {
        if(customer.Verified) {
          next();
        }
        else {
          res.json({status:'False',msg:'Phone number verification required.'});
        }
      })
      .catch(err => res.json(err));
  }
  else
   {
    res.json({status:'False', msg:'You must be logged in to access this feature.'});
    return;
  }

};

module.exports = userAuth;
