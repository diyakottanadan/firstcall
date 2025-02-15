const Rescue=require('../models/rescue');
exports.Register=(req,res)=>{
    console.log(req.body);
     Rescue.findOne({email:req.body.email}).then((rescue)=>{
        if(rescue){
            return res.status(400).json({message: "User already exists"});
        }
        let newRescue=new Rescue(req.body);
        newRescue.save().then((newRescue)=>{
            if(newUser){
                return res.status(200).json({message:"User created successfully"});
            }
            else{
                return res.status(500).json({message:"Internal error"});
            }
        })
     })
}

exports.login =(req,res)=>{
    Rescue.findOne({email:req.body.email}).then((rescue)=> {
        if(rescue){
            Rescue.findOne({email:req.body.email,password:req.body.password}).then((exist)=>{
            if(exist){
            return res.status(200).json(exist);
        }

         else{
            return res.status(400).json({message:"invalid password"});

         }

    })
}
else{
    return res.status(400).json({message:"user not found"});
}
    })
    
    
}
