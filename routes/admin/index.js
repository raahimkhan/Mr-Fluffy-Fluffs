const router = require('express').Router();
const login  = require('./login');
const admin  = require('./admin');
const logout = require('./logout');
const auth   = require('../../src/authentication/admin');

router.get('/',auth,admin.getAll);
router.get('/:username',auth,admin.get);
router.post('/login',login);
router.put('/',auth,admin.put);
router.delete('/:username',auth,admin.remove);
router.patch('/:username',auth,admin.patch);
router.post('/logout',auth,logout);



module.exports = router;
