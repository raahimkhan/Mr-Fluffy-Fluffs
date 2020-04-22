const session = require('express-session');
const mongoose = require('mongoose');
const Admin = require('../models/Admin.model');

const adminAuth = (req,res,next) => {

  if(req.session.Email && req.session.PassHash) {
    Admin.findOne({Email:req.session.Email,PassHash:req.session.PassHash}, (err,admin) => {

      if(err) {
        req.session.destroy();
        res.json({status:'False',msg:'You must be logged in to access this feature.'});
      }
      else {
        if(admin) {
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

module.exports = adminAuth;
