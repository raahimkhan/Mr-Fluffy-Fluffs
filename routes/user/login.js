const mongoose = require('mongoose');
const session  = require('express-session');
const Customer = require('../../src/models/Customer.model');
const bcrypt   = require('bcrypt');

const login = (req,res) => {

  if((req.session.Username || req.session.Email) && req.session.PassHash)
  {
    let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash}
    Customer.findOne(credentials, (err,customer) => {
      if(err) {
        //handle error
      }
      else {
        if(customer) {
          res.json({status:'True',msg:'Customer Already logged in.'});
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
      let credentials = req.body.customer.Username ? {Username:req.body.customer.Username} : {Email:req.body.customer.Email}
      Customer.findOne(credentials, (err,customer) => {
        if(err) {
          res.json({status:'False',msg:'Invalid Username or Password.'});
        }
        else {
          if(customer) {
            bcrypt.compare(req.body.customer.PassHash,customer.PassHash,(err,match) => {
              if(match) {
                if(req.body.customer.Username) {
                  req.session.Username = req.body.customer.Username;
                }
                else {
                  req.session.Email = req.body.customer.Email
                }
                req.session.PassHash = customer.PassHash;
                res.json({status:'True',msg:'Customer logged in.'});
              }
              else {
                res.json({status:'False',msg:'Invalid Username or Password.'});
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
