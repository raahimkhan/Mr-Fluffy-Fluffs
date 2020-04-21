const mongoose = require('mongoose');
const Customer = require('../../src/models/Customer.model');

const signup = (req,res) => {

  let data = JSON.parse(req.body);

  console.log(data);
  console.log(data.customer.Email);

  try {

    Customer.findOne({Email:data.customer.Email}, (err,customer) => {
      if(err) {
        res.json({status:'False',msg:'Internal Server Error.'});
      }
      else {

        if(customer == null) {

          let newCustomer = new Customer({

            _id      : new mongoose.Types.ObjectId(),
            FullName : data.customer.FullName,
            Username : data.customer.Username,
            PassHash : data.customer.PassHash,
            Address  : data.customer.Address,
            Email    : data.customer.Email,
            MobileNo : data.customer.MobileNo

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
