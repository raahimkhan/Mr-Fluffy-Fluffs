const app = require('express')();

const admin   = require('./admin/index');
const user    = require('./user/index');
const guest   = require('./guest/index');

app.use('/guest',guest);
app.use('/admin',admin);
app.use('/user',user);

module.exports = app;
