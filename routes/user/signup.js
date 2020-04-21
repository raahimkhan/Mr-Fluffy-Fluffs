const mongoose = require('mongoose');
const Customer = require('../../src/models/Customer.model');

const signup = (req,res) => {

  try {

    Customer.findOne({Email:req.body.customer.Email}, (err,customer) => {
      if(err) {
        res.json({status:'False',msg:'Internal Server Error.'});
      }
      else {

        if(customer == null) {

          let newCustomer = new Customer({

            _id      : new mongoose.Types.ObjectId(),
            FullName : req.body.customer.FullName,
            Username : req.body.customer.Username,
            PassHash : req.body.customer.PassHash,
            Address  : req.body.customer.Address,
            Email    : req.body.customer.Email,
            MobileNo : req.body.customer.MobileNo

          });

          newCustomer.save((err,customer) => {
            if(err) {
              res.json({status:'False',msg:'Cannot add customer.'});
            }
            else {
              res.json({status:'True',msg:'Customer added.'});
            }
          });

        } else {
          res.json({status:'False',msg:'Customer already present.'});
        }
      }
    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

module.exports = signup;
