const mongoose = require('mongoose');
const Custom   = require('../../src/models/Custom.model');
const Review   = require('../../src/models/Review.model');

const get = (req,res) => {

  Review.find({}, (err,reviews) => {
    if(err) {
      res.json({status:'False',msg:'Internal Database Error'});
    }
    else {
      if(reviews) {
          console.log(reviews.length());
          res.json({status:'True',msg:'Leaderboard'});
      }
      else {
        res.json({status:'False',msg:'No reviews present.'});
      }
    }
  });

};

module.exports = {get};
