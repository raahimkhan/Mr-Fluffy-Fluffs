const session = require('express-session');

const logout = (req,res) => {

  if(req.session.Email && req.session.PassHash) {
    req.session.destroy();
    res.json({status:'True',msg:'Admin logged out.'});
  }
  else {
    res.json({status:'False',msg:'Admin not logged in.'});
  }

};

module.exports = logout;
