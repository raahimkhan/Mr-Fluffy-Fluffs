mongoose= require('mongoose')
schema = mongoose.Schema

Topping=new schema({
	_id: schema.Types.ObjectId,
	Name:String,
	Price:Number
})

module.exports=mongoose.model('Topping',Topping)
