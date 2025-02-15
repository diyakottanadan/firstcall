const Forest=require('../models/forest');
exports.Register=(req,res)=>{
    console.log(req.body);
    Forest.findOne({email:req.body.email}).then((forest)=>{
        if(user){
            return res.status(400).json({message: "User already exists"});
        }
        let newForest=new Forest(req.body);
        newForest.save().then((newForest)=>{
            if(newForest){
                return res.status(200).json({message:"User created successfully"});
            }
            else{
                return res.status(500).json({message:"Internal error"});
            }
        })
     })
}

exports.login =(req,res)=>{
    Forest.findOne({email:req.body.email}).then((forest)=> {
        if(forest){
            Forest.findOne({email:req.body.email,password:req.body.password}).then((exist)=>{
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