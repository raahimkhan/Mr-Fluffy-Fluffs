mongoose= require('mongoose')
schema = mongoose.Schema

Service=new schema({
	_id: schema.Types.ObjectId,
	Name:String,
	Status:Boolean
})

module.exports=mongoose.model('Service',Service)
