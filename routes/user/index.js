const router = require('express').Router();

const login  = require('./login');
const logout = require('./logout');
const cart   = require('./cart');
const customs  = require('./customs');
const user   = require('./user');
const reviews = require('./reviews');
const userAuth   = require('../../src/authentication/user');
const adminAuth = require('../../src/authentication/admin');

router.get('/customs', customs.getCustoms);
router.get('/customs/:customid',customs.getCustom);
router.get('/customs/:customid/reviews',customs.getCustomReviews);

router.post('/login', login);
router.post('/logout',userAuth,logout);

router.get('/',adminAuth,user.getAll);
router.get('/:userid',adminAuth,user.get);

router.put('/',            user.put);
router.patch('/:userid', userAuth ,user.patch);
router.delete('/:userid',userAuth,user.remove);


router.get('/:userid/cart',          cart.get);
router.put('/:userid/cart',          cart.put);
router.delete('/:userid/cart/:itemid', cart.remove);
router.delete('/:userid/cart',       cart.removeAll);

router.get('/:userid/reviews', reviews.getAll);


router.get('/:userid/customs',customs.getUserCustoms);
router.put('/:userid/customs',userAuth, customs.put);
router.delete('/customs/:customid',userAuth,customs.remove);
router.delete('/:userid/customs',userAuth,customs.removeAll);

module.exports = router;
