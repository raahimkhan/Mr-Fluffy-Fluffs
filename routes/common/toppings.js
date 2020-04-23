const mongoose = require('mongoose');
const Topping  = require('../../src/models/Toppings.model');

const get = (req,res) => {

  try {

    Topping.findOne({_id:req.params.name}, (err,topping) => {
      if(err) {
        res.json({status:'False',msg:'Requested topping not present.'});
      }
      else {
        if(topping) {
          res.json({status:'True',msg:'Topping found.',data:topping});
        }
        else {
          res.json({status:'False',msg:'Requested topping not present.'});
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
    Topping.find({}, (err,topping) => {
      res.json({status:'True', msg:'Toppings', data:topping});
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const put = (req,res) => {

  try {

    Topping.findOne({Name:req.body.topping.Name}, (err,topping) => {
      if(err) {
        res.json({status:'False',msg:'Requested topping not present.'});
      }
      else {
        if(topping) {
          res.json({status:'False',msg:'Topping already present.'});
        }
        else {

          let newTopping = new Topping(

            {
            _id   : new mongoose.Types.ObjectId(),
            Name  : req.body.topping.Name,
            Price : req.body.topping.Price
            }
          );
          newTopping.save((err,topping) => {
            if(err) {
              res.json({status:'False',msg:'Cannot add topping.'});
            }
            else {
              res.json({status:'True',msg:'Topping added.'});
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

    Topping.updateOne({_id:req.params.name},{$set:req.body.topping},{multi:true}, (err,topping) => {

      if(err) {
        res.json({status:'False',msg:'Topping not present.'});
      }
      else {
        if(topping.updatedCount) {
          res.json({status:'True',msg:'Topping record updated.'});
        }
        else {
          res.json({status:'False',msg:'Cannot update topping record.'});
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

    Topping.deleteOne({_id:req.params.name}, (err,topping) => {

      if(err) {
        res.json({status:'False',msg:'Topping not present.'});
      }
      else {
        if(topping.deletedCount) {
          res.json({status:'True',msg:'Topping record deleted.'});
        }
        else {
          res.json({status:'False',msg:'Topping not present'});
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
