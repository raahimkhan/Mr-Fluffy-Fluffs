const get = (req,res) => {
  res.json(`get ${req.params['cake']} from ${req.params['username']}'s cakes`);
}

const put = (req,res) => {
  res.json(`put new cake in list of ${req.params['username']}'s cakes`);
}

const remove = (req,res) => {
  res.json(`remove ${req.params['cake']} from list of ${req.params['username']}'s cakes`);
}

const removeAll = (req,res) => {
  res.json(`remove all cakes of ${req.params['username']}`);
}

const getAll = (req,res) => {
  res.json(`get all cakes of ${req.params['username']}`);
}

module.exports = {
  get,put,remove,removeAll,getAll
};
