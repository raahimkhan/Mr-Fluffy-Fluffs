mongoose= require('mongoose')
schema = mongoose.Schema

Customer= new schema({
	_id: schema.Types.ObjectId,
	FullName:String,
	Username:String,
	PassHash:String,
	Address:String,
	Email:String,
	MobileNo:Number
})
module.exports=mongoose.model('Customer',Customer)
