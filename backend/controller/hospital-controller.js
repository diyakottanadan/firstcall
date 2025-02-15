const Hospital=require('../models/hospital');
exports.Register=(req,res)=>{
    console.log(req.body);
    Hospital.findOne({email:req.body.email}).then((hospital)=>{
        if(user){
            return res.status(400).json({message: "User already exists"});
        }
        let newHospital=new Hospital(req.body);
        newHospital.save().then((newHospital)=>{
            if(newHospital){
                return res.status(200).json({message:"User created successfully"});
            }
            else{
                return res.status(500).json({message:"Internal error"});
            }
        })
     })
}

exports.login =(req,res)=>{
    Hospital.findOne({email:req.body.email}).then((hospital)=> {
        if(hospital){
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