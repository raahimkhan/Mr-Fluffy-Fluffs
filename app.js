const db            = require('./src/db_connection');
const express       = require('express');
const app           = express();
const server        = require('http').createServer(app);
const router        = require('express').Router();
const session       = require('express-session');
const index         = require('./routes/index');
const api           = require('./routes/api');
const session_store = require('connect-mongo')(session);
const {uuid}        = require('uuidv4');
const mongoose      = require('mongoose');


const session_options = {
    secret:process.env.SESSION_SECRET,
    saveUninitialized:true,
    resave:true,
    name:'fluffy_fluffs_session_id',
    cookie: {
      httpOnly:true,
      secure:false, // for production use true
      sameSite:true,
      maxAge:86400 // valid for 30 minutes only
    },
    store:new session_store({mongooseConnection:mongoose.connection}),
    genid: function(req) {
      return uuid();
    }
}

app.use(session(session_options));
app.use(express.urlencoded({extended:true}));
app.use(express.json());
app.use('/',index);
app.use('/api',api);

port = process.env.PORT || 8080;

server.listen(port);
