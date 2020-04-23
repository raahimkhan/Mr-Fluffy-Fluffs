const mongoose = require('mongoose');
const Custom = require('../../src/models/Custom.model');
const Customer = require('../../src/models/Customer.model');
const Review   = require('../../src/models/Review.model');

const getCustoms = (req,res) => {

  try {
    Custom.find({}, (err,customs) => {

      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {
        if(customs) {
          res.json({status:'True',msg:'Custom cakes found.',data:customs});
        }
        else {
          res.json({status:'False',msg:'Cannot find any custom cakes.'});
        }
      }

    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const getUserCustoms = (req,res) => {

  try {
    Customer.findOne({_id:req.params.userid}, (err,customer) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error'});
      }
      else {
        if(customer) {
          Custom.find({MadeBy:customer._id}, (err,customs) => {
            if(err) {
              res.json({status:'False',msg:'Internal Database Error.'});
            }
            else {
              if(customs) {
                res.json({status:'True',msg:'Custom cakes of user found.',data:customs});
              }
              else {
                res.json({status:'False',msg:'Cannot find custom cakes of user.'});
              }
            }
          });
        }
        else {
          res.json({status:'False',msg:'Cannot find user.'});
        }
      }
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const getCustom = (req,res) => {

  try {
    Custom.findOne({_id:req.params.customid}, (err,custom) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {
        if(custom) {
          res.json({status:'True',msg:'Custom cake of user found.',data:custom});
        }
        else {
          res.json({status:'False',msg:'Cannot find custom cake of user.'});
        }
      }
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const getCustomReviews = (req,res) => {

  try {
    Review.find({Pancake:req.params.customid}, (err,reviews) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {
        if(reviews) {
          res.json({status:'True',msg:'Reviews found.',data:reviews});
        }
        else {
          res.json({status:'False',msg:'Cannot find reviews'});
        }
      }
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const put = (req,res) => {
  try {
    Customer.findOne({_id:req.params.userid}, (err,customer) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {
        if(customer) {
          let newCustom = new Custom({
            _id         : new mongoose.Types.ObjectId(),
            Name        : req.body.custom.Name,
            Description : req.body.custom.Description,
            Filling     : req.body.custom.Filling,
            Topping     : req.body.custom.Topping,
            MadeBy      : customer._id
          });
          newCustom.save((err,custom) => {
            if(err) {
              res.json({status:'False',msg:'Internal Database Error.'});
            }
            else {
              res.json({status:'True',msg:'Custom pancake added.'});
            }
          });
        }
        else {
          res.json({status:'False',msg:'Cannot find customer.'});
        }
      }
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }
};

const removeAll = (req,res) => {

  try {
    Customer.findOne({_id:req.params.userid},(err,customer) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {
        if(customer) {
          Custom.delete({MadeBy:customer._id}, (err,customs) => {
            if(err) {
              res.json({status:'False',msg:'Internal Database Error.'});
            }
            else {
              res.json({status:'True',msg:'Custom pancakes of user deleted.'});
            }
          });
        }
        else {
          res.json({status:'False',msg:'Cannot find user.'});
        }
      }
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const remove = (req,res) => {

  try {
    Customer.findOne({_id:req.params.userid},(err,customer) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {
        if(customer) {
          Custom.deleteOne({_id:req.params.customid,MadeBy:customer._id}, (err,customs) => {
            if(err) {
              res.json({status:'False',msg:'Internal Database Error.'});
            }
            else {
              res.json({status:'True',msg:'Custom pancake of user deleted.'});
            }
          });
        }
        else {
          res.json({status:'False',msg:'Cannot find user.'});
        }
      }
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};


module.exports = {
  getUserCustoms,getCustom,getCustoms,getCustomReviews,put,remove,removeAll
};
