const User=require('../models/user');
exports.Register=(req,res)=>{
    console.log(req.body);
     User.findOne({email:req.body.email}).then((user)=>{
        if(user){
            return res.status(400).json({message: "User already exists"});
        }
        let newUser=new User(req.body);
        newUser.save().then((newUser)=>{
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
    User.findOne({email:req.body.email}).then((user)=> {
        if(user){
         User.findOne({email:req.body.email,password:req.body.password}).then((exist)=>{
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