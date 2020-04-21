mongoose= require('mongoose')
schema = mongoose.Schema

Admin=new schema({
	_id: schema.Types.ObjectId,
	FullName:String,
	Username:String,
	Email:String,
	PassHash:String
})



module.exports=mongoose.model('Admin',Admin)