const mongoose = require('mongoose');
const session  = require('express-session');
const Admin = require('../../src/models/Admin.model');

const login = (req,res) => {

  if(req.session.Email && req.session.PassHash)
  {
    Admin.findOne({Email:req.session.Email,PassHash:req.session.PassHash}, (err,admin) => {
      if(err) {
        //handle error
      }
      else {
        if(customer) {
          res.json({status:'True',msg:'Admin Already logged in.'});
        }
      }
    });
  }
  else {
    try {

      Admin.findOne({Email:req.body.customer.Email,PassHash:req.body.admin.PassHash}, (err,admin) => {
        if(err) {
          res.json({status:'False',msg:'Invalid Username or Password.'});
        }
        else {
          if(admin) {
            req.session.Email    = req.body.admin.Email;
            req.session.PassHash = req.body.admin.PassHash;
            res.json({status:'True',msg:'Admin logged in.'});
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
