const mongoose = require('mongoose');
const Filling  = require('../../src/models/Fillings.model');

const get = (req,res) => {

  try {
    Filling.findOne({Name:req.params.name}, (err,filling) => {
      if(err) {
        res.json({status:'False',msg:'Requested filling not present.'});
      }
      else {
        if(filling) {
          res.json({status:'True',msg:'Filling found.',data:filling});
        }
        else {
          res.json({status:'False',msg:'Requested filling not present.'});
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
    Filling.find({}, (err,filling) => {
      res.json({status:'True', msg:'Fillings', data:filling});
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const put = (req,res) => {

  try {

    Filling.findOne({Name:req.body.filling.Name}, (err,filling) => {
      if(err) {
        res.json({status:'False',msg:'Requested filling not present.'});
      }
      else {
        if(filling) {
          res.json({status:'False',msg:'Filling already present.'});
        }
        else {

          let newFilling = new Filling(

            {
            _id: new mongoose.Types.ObjectId(),
            Name: req.body.filling.Name,
            Price: req.body.filling.Price
            }
          );
          newFilling.save((err,filling) => {
            if(err) {
              res.json({status:'False',msg:'Cannot add filling.'});
            }
            else {
              res.json({status:'True',msg:'Filling added.'});
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

    Filling.updateOne({Name:req.params.name},{$set:req.body.filling},{multi:true}, (err,filling) => {

      if(err) {
        res.json({status:'False',msg:'Filling not present.'});
      }
      else {
        res.json({status:'True',msg:'Filling record updated.'});
      }

    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const remove = (req,res) => {

  try {

    Filling.deleteOne({Name:req.params.name}, (err,filling) => {

      if(err) {
        res.json({status:'False',msg:'Filling not present.'});
      }
      else {
        if(filling.deletedCount) {
          res.json({status:'True',msg:'Filling record deleted.'});
        }
        else {
          res.json({status:'False',msg:'Filling not present'});
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
