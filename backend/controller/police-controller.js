const Police=require('../models/police');
exports.Register=(req,res)=>{
    console.log(req.body);
     User.findOne({email:req.body.email}).then((police)=>{
        if(user){
            return res.status(400).json({message: "User already exists"});
        }
        let newPolice=new Police(req.body);
        newPolice.save().then((newPolice)=>{
            if(newPolice){
                return res.status(200).json({message:"User created successfully"});
            }
            else{
                return res.status(500).json({message:"Internal error"});
            }
        })
     })
}

exports.login =(req,res)=>{
    Police.findOne({email:req.body.email}).then((police)=> {
        if(police){
            Police.findOne({email:req.body.email,password:req.body.password}).then((exist)=>{
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