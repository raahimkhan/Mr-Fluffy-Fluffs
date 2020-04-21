
const mongoose = require('mongoose');
const URL      = 'mongodb://127.0.0.1:27017/mr-fluffy-fluffs';

const db = mongoose.connect(URL,{useNewUrlParser:true,useUnifiedTopology:true})
.then(() => {
  console.log('Connected to database.');
})
.catch((err) => {
  console.log('Error: Cannot connect to database.');
});
