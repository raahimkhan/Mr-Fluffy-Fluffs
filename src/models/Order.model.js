mongoose= require('mongoose')
schema = mongoose.Schema

Order=new schema({
	_id: schema.Types.ObjectId,
	Date:Date,
	Status:String,
	Order:{
		type: mongoose.Schema.Types.ObjectId,
        ref: 'Cart'
	},

},
{
		timestamps:true
})

module.exports=mongoose.model('Order',Order)
