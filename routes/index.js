const router = require('express').Router();

router.get('/',(req,res) => {
  res.json('home');
});

module.exports = router;
