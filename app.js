const express = require('express');
const app     = express();
const server  = require('http').createServer(app);
const router  = require('express').Router();
const session = require('express-session');
const index   = require('./routes/index');
const api     = require('./routes/api');
const db      = require('./src/db_connection');

app.use(session(
  {
    secret:'some_daMn-Goods3cr3t',
    saveUninitialized:true,
    resave:true,
    name:'s3Cr3tN@m3',
    cookie: {
      httpOnly:true,
      secure:false, // for production use true
      sameSite:true,
      maxAge:86400 // valid for one day only
    }
  }
  ));

app.use(express.urlencoded({extended:true}));
app.use(express.json());
app.use('/',index);
app.use('/api',api);

port = process.env.PORT || 8080;

server.listen(port);
