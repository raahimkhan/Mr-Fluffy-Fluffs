const app     = require('express')();
const server  = require('http').createServer(app);
const router  = require('express').Router();
const index   = require('./routes/index');
const api     = require('./routes/api');

app.use('/',index);
app.use('/api',api);

port = process.env.PORT || 8080;

server.listen(port);
console.log(port);
