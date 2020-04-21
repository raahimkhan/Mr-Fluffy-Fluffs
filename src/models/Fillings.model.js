mongoose= require('mongoose')
schema = mongoose.Schema

Filling=new schema({
	_id: schema.Types.ObjectId,
	Name:String,
	Price:Number
})


module.exports=mongoose.model('Filling',Filling)
