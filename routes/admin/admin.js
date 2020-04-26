const mongoose  = require('mongoose');
const utility   = require('../../src/Utility');
const bcrypt    = require('bcrypt');
const Admin    = require('../../src/models/Admin.model');

const get = (req,res) => {

  utility.getOne(Admin,{_id:req.params.adminid})
  .then(data => res.json(data))
  .catch(err => res.json(err));

}

const getAll = (req,res) => {

  utility.getAll(Admin,{})
  .then(data => res.json(data))
  .catch(err => res.json(err));

}

const remove = (req,res) => {

  utility.removeOne(Admin,{_id:req.params.adminid})
  .then(data => res.json(data))
  .catch(err => res.json(err));

};

const patch = (req,res) => {

  utility.patchOne(Admin,{_id:req.params.adminid},{$set:req.body.admin},{multi:true})
  .then(data => res.json(data))
  .catch(err => res.json(err));

};

const put = (req,res) => {

  const salt_iterations = 10;
  bcrypt.hash(req.body.admin.PassHash,salt_iterations, (err,hash) => {
    if(err) {
      res.json({status:'False',msg:'Cannot hash admin password.'});
    }
    else {
      let data = {
        _id      : new mongoose.Types.ObjectId(),
        FullName : req.body.admin.FullName,
        Username : req.body.admin.Username,
        PassHash : hash,
        Email    : req.body.admin.Email
      };

      utility.put(Admin,data)
      .then(data => res.json(data))
      .catch(err => res.json(err));
    }
  });

};

module.exports = {remove,patch,put,getAll,get};
