const router = require('express').Router();
const login  = require('./login');
const admin  = require('./admin');
const logout = require('./logout');

router.get('/', admin.getAll);
router.get('/:username',admin.get);
router.post('/login',login);
router.put('/', admin.put);
router.delete('/:username',admin.remove);
router.patch('/:username', admin.patch);
router.post('/logout',logout);



module.exports = router;
