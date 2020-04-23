const mongoose = require('mongoose');
const Admin = require('../../src/models/Admin.model');
const bcrypt = require('bcrypt');

const get = (req,res) => {
  try {
    Admin.findOne({_id:req.params.adminid}, (err,admin) => {
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
    Admin.find({}, (err,admin) => {
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

    Admin.deleteOne({_id:req.params.adminid}, (err,admin) => {

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

    Admin.updateOne({_id:req.params.adminid},{$set:req.body.admin},{multi:true}, (err,admin) => {

      if(err) {
        res.json({status:'False',msg:'Admin not present.'});
      }
      else {
        if(admin.updatedCount) {
          res.json({status:'True',msg:'Admin record updated.'});
        }
        else {
          res.json({status:'False',msg:'Cannot update admin record.'});
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

    Admin.findOne({Email:req.body.admin.Email}, (err,admin) => {
      if(err) {
        res.json({status:'False',msg:'Internal Database Error.'});
      }
      else {

        if(admin == null) {

          const salt_iterations = 10;
          bcrypt.hash(req.body.admin.PassHash,salt_iterations, (err,hash) => {
            if(err) {
              res.json({status:'False',msg:'Cannot hash admin password.'});
            }
            else {
              let newAdmin = new Admin({

                _id      : new mongoose.Types.ObjectId(),
                FullName : req.body.admin.FullName,
                Username : req.body.admin.Username,
                PassHash : hash,
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
