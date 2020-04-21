mongoose= require('mongoose')
schema = mongoose.Schema

Board=new schema({
	_id: schema.Types.ObjectId,
	Pancake:{
	    type: mongoose.Schema.Types.ObjectId,
        ref: 'Custom'
	},
	MadeBy:{
	type:mongoose.Schema.Types.ObjectId,
	ref:'Customer'
	},

	Agg_points:Number

})


module.exports= mongoose.model('Board',Board)