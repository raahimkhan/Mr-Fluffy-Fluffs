const mongoose = require('mongoose');
const utility = require('../../src/Utility');
const Custom = require('../../src/models/Custom.model');
const Customer = require('../../src/models/Customer.model');
const Review   = require('../../src/models/Review.model');



const getUserCustoms = (req,res) => {

  let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash};

  utility.getOne(Customer,credentials)
  .then(customer => {
    utility.getAll(Custom,{MadeBy:customer._id})
    .then(customs => res.json({status:'True',msg:'Custom cakes of user found.',data:customs}))
    .catch(err => res.json(err));
  })
  .catch(err => res.json(err));

};


const put = (req,res) => {

  let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash};

  utility.getOne(Customer,credentials)
  .then(customer => {

    let data={
      _id         : new mongoose.Types.ObjectId(),
      Name        : req.body.custom.Name,
      Description : req.body.custom.Description,
      Filling     : req.body.custom.Filling,
      Topping     : req.body.custom.Topping,
      MadeBy      : customer._id
    };

    utility.put(Custom,data)
    .then(custom => res.json({status:'True',msg:'Custom cake added.'}))
    .catch(err => res.json(err));

  })
  .catch(err => res.json(err));

};

const removeAll = (req,res) => {

  let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash};

  utility.getOne(Customer,credentials)
  .then(customer => {
    utility.removeAll(Custom,{MadeBy:customer._id})
    .then(custom => res.json({status:'True',msg:'Custom cakes removed.'}))
    .catch(err => res.json(err));
  })
  .catch(err => res.json(err));

};

const remove = (req,res) => {

  let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash};

  utility.getOne(Customer,credentials)
  .then(customer => {
    utility.removeOne(Custom,{_id:req.params.customid})
    .then(custom => res.json({status:'True',msg:'Custom cake found.'}))
    .catch(err => res.json(err));
  })
  .catch(err => res.json(err));
};


module.exports = {
  getUserCustoms,put,remove,removeAll
};
