const mongoose = require('mongoose');
const Customer = require('../../src/models/Customer.model');
const bcrypt   = require('bcrypt');

const remove = (req,res) => {

  try {

    Customer.deleteOne({_id:req.params.userid}, (err,customer) => {

      if(err) {
        res.json({status:'False',msg:'Customer not present.'});
      }
      else {
        if(customer.deletedCount) {
          res.json({status:'True',msg:'Customer record deleted.'});
        }
        else {
          res.json({status:'False',msg:'Customer not present'});
        }
      }

    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const patch = (req,res) => {

  try {

    Customer.updateOne({_id:req.params.userid},{$set:req.body.customer},{multi:true}, (err,customer) => {

      if(err) {
        res.json({status:'False',msg:'Customer not present.'});
      }
      else {
        res.json({status:'True',msg:'Customer record updated.'});
      }

    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const put = (req,res) => {

  try {

    Customer.findOne({Email:req.body.customer.Email}, (err,customer) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {

        if(customer == null) {

          const salt_iterations = 10;
          bcrypt.hash(req.body.customer.PassHash,salt_iterations,(err,hash) => {
            if(err) {
              res.json({status:'False',msg:'Error hashing user password.'});
            }
            else {
              let newCustomer = new Customer({

                _id      : new mongoose.Types.ObjectId(),
                FullName : req.body.customer.FullName,
                Username : req.body.customer.Username,
                PassHash : hash,
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

const get = (req,res) => {
  try {
    Customer.findOne({_id:req.params.userid}, (err,customer) => {
      if(err) {
        res.json({status:'False',msg:'Requested customer not present.'});
      }
      else {
        if(cake) {
          res.json({status:'True',msg:'Customer found.',data:customer});
        }
        else {
          res.json({status:'False',msg:'Requested customer not present.'});
        }
      }
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }
};

const getAll = (req,res) => {

  Customer.find({}, (err,customer) => {
    res.json({status:'True', msg:'Customers', data:customer});
  });

};

module.exports = {remove,patch,put,get,getAll};
