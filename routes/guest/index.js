const router = require('express').Router();

router.get('/login', (req,res) => {
  res.json('login : guest');
});

router.get('/logout', (req,res) => {
  res.json('logout : guest');
});

module.exports = router;
