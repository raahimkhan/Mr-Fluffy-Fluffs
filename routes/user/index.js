const router = require('express').Router();

const login  = require('./login');
const logout = require('./logout');
const cart   = require('./cart');
const cakes  = require('./cakes');
const user   = require('./user');
const userAuth   = require('../../src/authentication/user');
const adminAuth = require('../../src/authentication/admin');

router.post('/login', login);
router.post('/logout',adminAuth,logout);

router.get('/',adminAuth,user.getAll);
router.get('/:username',adminAuth,user.get);

router.put('/',            user.put);
router.patch('/:username', userAuth ,user.patch);
router.delete('/:username',userAuth,user.remove);


router.get('/:username/cart',          cart.get);
router.put('/:username/cart',          cart.put);
router.delete('/:username/cart/:item', cart.remove);
router.delete('/:username/cart',       cart.removeAll);

router.get('/:username/cakes',          cakes.getAll);
router.get('/:username/cakes/:cake',    cakes.get);
router.put('/:username/cakes',          cakes.put);
router.delete('/:username/cakes/:cake', cakes.remove);
router.delete('/:username/cakes',       cakes.removeAll);

module.exports = router;
