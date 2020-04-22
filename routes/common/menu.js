const mongoose = require('mongoose');
const Pancake  = require('../../src/models/Pancake.model');

const get = (req,res) => {

  try {

    Pancake.findOne({Name:req.params.item}, (err,cake) => {
      if(err) {
        res.json({status:'False',msg:'Requested pancake not present.'});
      }
      else {
        if(cake) {
          res.json({status:'True',msg:'Pancake found.',data:cake});
        }
        else {
          res.json({status:'False',msg:'Requested pancake not present.'});
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
    Pancake.find({}, (err,cake) => {
      res.json({status:'True', msg:'Pancakes', data:cake});
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const put = (req,res) => {

  try {

    Pancake.findOne({Name:req.body.menu.Name}, (err,cake) => {
      if(err) {
        res.json({status:'False',msg:'Requested pancake not present.'});
      }
      else {
        if(cake) {
          res.json({status:'False',msg:'Pancake already present.'});
        }
        else {

          let newPancake = new Pancake(

            {
            _id: new mongoose.Types.ObjectId(),
            Name: req.body.pancake.Name,
            Description: req.body.pancake.Description,
            Price: req.body.pancake.Price
            }
          );
          newPancake.save((err,cake) => {
            if(err) {
              res.json({status:'False',msg:'Cannot add pancake.'});
            }
            else {
              res.json({status:'True',msg:'Pancake added.'});
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

    Pancake.updateOne({Name:req.params.item},{$set:req.body.pancake},{multi:true}, (err,cake) => {

      if(err) {
        res.json({status:'False',msg:'Pancake not present.'});
      }
      else {
        res.json({status:'True',msg:'Pancake record updated.'});
      }

    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const remove = (req,res) => {

  try {

    Pancake.deleteOne({Name:req.params.item}, (err,cake) => {

      if(err) {
        res.json({status:'False',msg:'Pancake not present.'});
      }
      else {
        if(cake.deletedCount) {
          res.json({status:'True',msg:'Pancake record deleted.'});
        }
        else {
          res.json({status:'False',msg:'Pancake not present'});
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
