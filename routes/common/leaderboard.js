const mongoose = require('mongoose');
const Board = require('../../src/models/LeaderBoard.model');

const getAll = (req,res) => {

  try {
    Board.find({}, (err,board) => {
      if(err) {
        res.json({status:'False',msg:'Leader Board is empty.'});
      }
      else {
        res.json({status:'True',msg:'Leader Board.',data:board});
      }
    });
  }
  catch(Error) {
    res.json({status:'False',msg:'Internal Server Error.'});
  }

}

module.exports = {getAll};
