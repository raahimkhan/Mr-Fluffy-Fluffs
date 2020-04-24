const guestAuth = (req,res,next) => {

  if(req.session.GuestId) {
    next()
  }
  else {
    res.json({status:'False',msg:'Guest Login needed.'});
  }

};
