const router = require('express').Router();

router.get('/login', (req,res) => {
  res.json('login : admin');
});

router.get('/logout', (req,res) => {
  res.json('logout : admin');
});

module.exports = router;
