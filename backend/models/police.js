const mongoose= require('mongoose');
var policeSchema= new mongoose.Schema({
   
    // userid:{
    //     type:mongoose.Scheme.Types.ObjectId,
    //     Ref:'user',
    //     required :true,
       
    // },
    email:{
        type:String,
        required:true
    },
    password:{
        type:String,
        required:true
    },
    country:{
        type:String,
        required:true
    },
    district:{
        type:String,
        required:true
    },
    state:{
        type:Number,
        required :true,
    },
    city:{
        type:String,
        required :true,
    },
    phn:{
        type:String,
        required :true,
    },

     userid:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
      },
    //   datetime:{
    //     type:Date,
    //     default:Date.now
    //   }
})
module.exports = mongoose.model('Police',policeSchema);