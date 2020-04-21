mongoose=require('mongoose')
schema = mongoose.Schema

Custom=new schema({
	_id:schema.Types.ObjectId,
	Name:String,
	Description:String,
	Layer:Number,
	Filling:[{
		type: mongoose.Schema.Types.ObjectId,
        ref: 'Filling'}],
    Topping:[{
    	type: mongoose.Schema.Types.ObjectId,
        ref: 'Topping'}],
    MadeBy:{
    	type: mongoose.Schema.Types.ObjectId,
        ref: 'Customer'}
})

module.exports=mongoose.model('Custom',Custom)