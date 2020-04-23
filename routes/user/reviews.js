const mongoose = require('mongoose');
const Review   = require('../../src/models/Review.model');
const Customer = require('../../src/models/Customer.model');

const getAll = (req,res) => {

  try {
    Customer.findOne({_id:req.params.userid}, (err,customer) => {

      if(err) {
        res.json({status:'False',msg:'Cannot find user.'});
      }
      else {
        if(customer) {
          Review.find({PostedBy:customer._id}, (err,reviews) => {
            if(err) {
              res.json({staus:'False',msg:'Cannot get reviews.'})
            }
            else {
              if(reviews) {
                res.json({status:'True',msg:'Reviews found.',data:reviews});
              }
              else {
                res.json({status:'False',msg:'Reviews not present.'});
              }
            }
          });
        }
        else {
          res.json({status:'False',msg:'User not present'});
        }
      }

    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

module.exports = {getAll};
