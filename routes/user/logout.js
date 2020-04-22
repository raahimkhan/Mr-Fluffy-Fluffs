const session = require('express-session');

const logout = (req,res) => {

  req.session.destroy();
  res.json({status:'True',msg:'User logged out.'});

};

module.exports = logout;
