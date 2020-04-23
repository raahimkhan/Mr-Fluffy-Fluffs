const mongoose = require('mongoose');
const session  = require('express-session');
const Admin = require('../../src/models/Admin.model');
const bcrypt  = require('bcrypt');

const login = (req,res) => {

  if(req.session.Email && req.session.PassHash)
  {
    Admin.findOne({Email:req.session.Email,PassHash:req.session.PassHash}, (err,admin) => {
      if(err) {
        //handle error
      }
      else {
        if(admin) {
          res.json({status:'True',msg:'Admin Already logged in.'});
        }
        else {
          req.session.destroy();
          res.json({status:'False',msg:'Credentials has been changed. Please log in again.'});
        }
      }
    });
  }
  else {
    try {

      Admin.findOne({Email:req.body.admin.Email}, (err,admin) => {
        if(err) {
          res.json({status:'False',msg:'Invalid Username or Password.'});
        }
        else {
          if(admin) {
            bcrypt.compare(req.body.admin.PassHash,admin.PassHash, (err,match) => {
                if(match) {
                req.session.Email    = req.body.admin.Email;
                req.session.PassHash = admin.PassHash;
                res.json({status:'True',msg:'Admin logged in.'});
              }
            });
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
