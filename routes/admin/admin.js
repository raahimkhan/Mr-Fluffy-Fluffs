const mongoose = require('mongoose');
const Admin = require('../../src/models/Admin.model');

const get = (req,res) => {
  try {
    Admin.findOne({Username:req.params.username}, (err,admin) => {
      if(err) {
        res.json({status:'False',msg:'No admins present.'});
      }
      else {
        if(admin !== null) {
          res.json({status:'True',msg:'Admins found.',data:admin});
        }
        else {
          res.json({status:'False',msg:'No admins present.'});
        }
      }

    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }
}

const getAll = (req,res) => {

  try {
    Admin.findMany({}, (err,admin) => {
      if(err) {
        res.json({status:'False',msg:'No admins present.'});
      }
      else {
        if(admin !== null) {
          res.json({status:'True',msg:'Admins found.',data:admin});
        }
        else {
          res.json({status:'False',msg:'No admins present.'});
        }
      }

    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

}

const remove = (req,res) => {

  try {

    Admin.deleteOne({Username:req.params.username}, (err,admin) => {

      if(err) {
        res.json({status:'False',msg:'Admin not present.'});
      }
      else {
        if(admin.deletedCount) {
          res.json({status:'True',msg:'Admin record deleted.'});
        }
        else {
          res.json({status:'False',msg:'Admin not present'});
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

    Admin.updateOne({Username:req.params.username},{$set:req.body.admin},{multi:true}, (err,admin) => {

      if(err) {
        res.json({status:'False',msg:'Admin not present.'});
      }
      else {
        res.json({status:'True',msg:'Admin record updated.'});
      }

    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const put = (req,res) => {


  try {

    Admin.findOne({Email:req.body.admin.Email}, (err,admin) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {

        if(admin == null) {

          let newAdmin = new Admin({

            _id      : new mongoose.Types.ObjectId(),
            FullName : req.body.admin.FullName,
            Username : req.body.admin.Username,
            PassHash : req.body.admin.PassHash,
            Email    : req.body.admin.Email

          });

          newAdmin.save((err,admin) => {
            if(err) {
              res.json({status:'False',msg:'Cannot add admin.'});
            }
            else {
              res.json({status:'True',msg:'Admin added.'});
            }
          });

        } else {
          res.json({status:'False',msg:'Admin already present.'});
        }
      }
    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

module.exports = {remove,patch,put,getAll,get};
