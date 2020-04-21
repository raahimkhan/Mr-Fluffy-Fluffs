const db   = require('../src/db_connection');
const User = require('../src/models/Customer.model');

const login = (req,res) => {

  //check session for the incoming request
    //if session present
      //response valid user
  //else session not present
  //validate username and passhash
    //if valid
        //create new session
        //response valid user
    //else not valid
        //response invalid user

};

module.exports = login;
