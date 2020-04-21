const mongoose = require('mongoose');
URI = 'mongodb://heroku_8xqcms5f:9bulhd34fvtiu0e7g4vct0s147@ds121026.mlab.com:21026/heroku_8xqcms5f'

const db = mongoose.connect(URI,{useNewUrlParser:true,useUnifiedTopology:true})
.then(() => {
  console.log('Connected to database.');
})
.catch((err) => {
  console.log('Error: Cannot connect to database.');
});

module.exports = db;
