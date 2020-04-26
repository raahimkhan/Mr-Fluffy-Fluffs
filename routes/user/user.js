const mongoose = require('mongoose');
const utility  = require('../../src/Utility');
const Customer = require('../../src/models/Customer.model');
const bcrypt   = require('bcrypt');
const Code    = require('../../src/models/Code.model')

const generate = async (req,res)=>{
 
  if (req.session.Email || req.session.Username){
    let credentials = req.session.Email ? {customer:req.session.Email} : {customer:req.session.Username};
    utility.getOne(Code,credentials).then(cod=>{
      //insert api here (await)

    })
  .catch(err =>async ()={
    code= Math.floor(Math.random() * 90000) + 10000
    //add to db
    co = new Code({
      _id : new mongoose.Types.ObjectId(),
      code : code,
      customer: credentials.customer
    })
    co.ttl = '1h' // lives for two minutes
    await co.save();
    //send it through api

  }

  }
  else{
    res.json({status:'True',msg:'User not Verified'});
  }
  return Math.floor(Math.random() * 90000) + 10000
}
const verify = (req,res) => {
  let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash};
  utility.getOne(Customer,credentials)
  .then(customer => {
    if(customer.Verified) {
      res.json({status:'True',msg:'Customer already verified.'});
    }
    else {

      utility.patchOne(Customer,credentials,{$set:{Verified:1}},{multi:true})
      .then(customer => res.json({status:'True',msg:'Customer verified.'}))
      .catch(err => res.json(err));
    }
  })
  .catch(err => res.json(err));
}

const remove = (req,res) => {
  let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash};
  utility.removeOne(Customer,credentials)
  .then(customer => {
    req.session.destroy();
    res.json({status:'True',msg:'Customer removed.'});
  })
  .catch(err => res.json(err));

};

const patch = (req,res) => {
  let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash};
  utility.patchOne(Customer,credentials,{$set:req.body.customer},{multi:true})
  .then(customer => res.json({status:'True',msg:'Customer updated.'}))
  .catch(err => res.json(err));

};

const put = (req,res) => {

  if(!(req.body.customer.Email && req.body.customer.Username && req.body.customer.PassHash && req.body.customer.MobileNo))
  {
    res.json({status:'False',msg:'Required fields are not set.'});
    return;
  }

  utility.getOne(Customer,{Email:req.body.customer.Email})
  .then(customer => res.json({status:'False',msg:'Email already present.'}))
  .catch(err => {
    utility.getOne(Customer,{Username:req.body.customer.Username})
    .then(customer => res.json({status:'False',msg:'Username already present.'}))
    .catch(err => {
      const salt_iterations = 10;
      bcrypt.hash(req.body.customer.PassHash,salt_iterations,(err,hash) => {
        if(err) {
          res.json({status:'False',msg:'Error hashing user password.'});
        }
        else {
          let data = {

            _id      : new mongoose.Types.ObjectId(),
            FullName : req.body.customer.FullName,
            Username : req.body.customer.Username,
            PassHash : hash,
            Address  : req.body.customer.Address,
            Email    : req.body.customer.Email,
            MobileNo : req.body.customer.MobileNo,
            Verified : 0

          };
         generate()
        
          utility.put(Customer,data)
          .then(customer => {
            req.session.Username = req.body.customer.Username;
            req.session.PassHash = hash;
            res.json({status:'True',msg:'Customer added and logged in. Verification Required for further access.'});
          })
          .catch(err => res.json(err));
        }
      });
    });
  });

};

const get = (req,res) => {

  let credentials = req.session.Email ? {Email:req.session.Email,PassHash:req.session.PassHash} : {Username:req.session.Username,PassHash:req.session.PassHash};

  utility.getOne(Customer,credentials)
  .then(customer => res.json({status:'True',msg:'Customer found.',data:customer}))
  .catch(err => res.json(err));
};

module.exports = {remove,patch,put,get,verify};
