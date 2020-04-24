const router = require('express').Router();
const {uuid} = require('uuidv4');

router.get('/login', (req,res) => {
  req.session.GuestId = uuid();
  res.json({status:'True',msg:`Guest logged in. Guest ID:${req.session.GuestId}`});
});

router.get('/logout', (req,res) => {
  if(req.session.GuestId) {
    req.session.store.destroy(req.session.sid);
    req.session.destroy();
    res.json({status:'True',msg:'Guest logged out.'});
  }
  else {
    res.json({status:'False',msg:'Guest not logged in.'});
  }
});

module.exports = router;
