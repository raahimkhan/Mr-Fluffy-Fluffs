const mongoose = require('mongoose');
const Review  = require('../../src/models/Review.model');

const get = (req,res) => {

  try {

    Review.findOne({Name:req.params.name}, (err,review) => {
      if(err) {
        res.json({status:'False',msg:'Requested review not present.'});
      }
      else {
        if(review) {
          res.json({status:'True',msg:'Review found.',data:review});
        }
        else {
          res.json({status:'False',msg:'Requested review not present.'});
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
    Review.find({}, (err,review) => {
      res.json({status:'True', msg:'Reviews', data:review});
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const put = (req,res) => {

  try {

    Review.findOne({Name:req.body.review.Name}, (err,review) => {
      if(err) {
        res.json({status:'False',msg:'Requested review not present.'});
      }
      else {
        if(review) {
          res.json({status:'False',msg:'Review already present.'});
        }
        else {

          let newReview = new Review(

            {
            _id: new mongoose.Types.ObjectId(),
            Name: req.body.review.Name,
            Status: req.body.review.Status
            }
          );
          newReview.save((err,review) => {
            if(err) {
              res.json({status:'False',msg:'Cannot add review.'});
            }
            else {
              res.json({status:'True',msg:'Review added.'});
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

    Review.updateOne({Name:req.params.name},{$set:req.body.review},{multi:true}, (err,review) => {

      if(err) {
        res.json({status:'False',msg:'Review not present.'});
      }
      else {
        res.json({status:'True',msg:'Review record updated.'});
      }

    });

  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

};

const remove = (req,res) => {

  try {

    Review.deleteOne({Name:req.params.name}, (err,review) => {

      if(err) {
        res.json({status:'False',msg:'Review not present.'});
      }
      else {
        if(review.deletedCount) {
          res.json({status:'True',msg:'Review record deleted.'});
        }
        else {
          res.json({status:'False',msg:'Review not present'});
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
