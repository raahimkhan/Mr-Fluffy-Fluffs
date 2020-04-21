const get = (req,res) => {
  res.json(`get cart of ${req.params['username']}`);
};

const put = (req,res) => {
  res.json(`put new item in cart of ${req.params['username']}`);
};

const remove = (req,res) => {
  res.json(`remove ${req.params['item']} from cart of ${req.params['username']}`);
};

const removeAll = (req,res) => {
  res.json(`remove all items from cart of ${req.params['username']}`);
}

module.exports = {
  get,put,remove,removeAll
};
