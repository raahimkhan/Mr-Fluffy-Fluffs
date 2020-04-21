mongoose= require('mongoose')
schema = mongoose.Schema

Cart= new schema({
	_id: schema.Types.ObjectId,
	Number_Items:Number,
	Total:Number,
	Tax:Number,
	Items:[{
		pancake:{
		type: mongoose.Schema.Types.ObjectId,
        ref: 'Pancake'},
        topping:[{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Topping'}]
		}],
	custom:{
		type: mongoose.Schema.Types.ObjectId,
        ref: 'Custom'
	},
	Customer:{
		type: mongoose.Schema.Types.ObjectId,
        ref: 'Customer'}
			
	
})


module.exports=mongoose.model('Cart',Cart)