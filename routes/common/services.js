const mongoose = require('mongoose');
const Service  = require('../../src/models/Service.model');

const get = (req,res) => {

  try {

    Service.findOne({Name:req.params.name}, (err,service) => {
      if(err) {
        res.json({status:'False',msg:'Requested service not present.'});
      }
      else {
        if(service) {
          res.json({status:'True',msg:'Service found.',data:service});
        }
        else {
          res.json({status:'False',msg:'Requested service not present.'});
        }
      }
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const getAll = (req,res) => {

  try {
    Service.find({}, (err,service) => {
      res.json({status:'True', msg:'Services', data:service});
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const put = (req,res) => {

  try {

    Service.findOne({Name:req.body.service.Name}, (err,service) => {
      if(err) {
        res.json({status:'False',msg:'Requested service not present.'});
      }
      else {
        if(service) {
          res.json({status:'False',msg:'Service already present.'});
        }
        else {

          let newService = new Service(

            {
            _id: new mongoose.Types.ObjectId(),
            Name: req.body.service.Name,
            Status: req.body.service.Status
            }
          );
          newService.save((err,service) => {
            if(err) {
              res.json({status:'False',msg:'Cannot add service.'});
            }
            else {
              res.json({status:'True',msg:'Service added.'});
            }
          });
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

    Service.updateOne({Name:req.params.name},{$set:req.body.service},{multi:true}, (err,service) => {

      if(err) {
        res.json({status:'False',msg:'Service not present.'});
      }
      else {
        res.json({status:'True',msg:'Service record updated.'});
      }

    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const remove = (req,res) => {

  try {

    Service.deleteOne({Name:req.params.name}, (err,service) => {

      if(err) {
        res.json({status:'False',msg:'Service not present.'});
      }
      else {
        if(service.deletedCount) {
          res.json({status:'True',msg:'Service record deleted.'});
        }
        else {
          res.json({status:'False',msg:'Service not present'});
        }
      }

    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }


};


module.exports = {
  getAll,get,put,patch,remove
};
