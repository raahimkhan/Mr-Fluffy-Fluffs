const router = require('express').Router();

const signup = require('./signup');
const login  = require('./login');
const logout = require('./logout');
const cart   = require('./cart');
const cakes  = require('./cakes');

router.post('/signup', signup);
router.post('/login',login);
router.post('/logout',logout);

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
