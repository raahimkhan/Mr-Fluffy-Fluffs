mongoose= require('mongoose')
schema = mongoose.Schema

Review= new schema({
	_id: schema.Types.ObjectId,
	Body:String,
	PostedBy:{
	type: mongoose.Schema.Types.ObjectId,
    ref: 'Customer'
	},
	Pancake:{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Custom'
	},
	Rating:Number

})
module.exports=mongoose.model('Review',Review)
