const mongoose = require('mongoose');
const Admin = require('../models/Admin.model');

const adminAuth = (req,res,next) => {

  if(req.session.Email && req.session.PassHash) {
    Admin.findOne({Email:req.session.Email,PassHash:req.session.PassHash}, (err,admin) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {
        if(admin) {
          next();
        }
        else {
          req.session.destroy();
          res.json({status:'False',msg:'Admin privileges required.'});
        }
      }

    });
  }
  else {
    res.json({status:'False', msg:'Admin privileges required.'});
    return;
  }

};

module.exports = adminAuth;
