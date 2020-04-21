const router = require('express').Router();

router.get('/',(req,res) => {
  res.send("This is a backend server for project Mr fluffy fluffs");
});

module.exports = router;
