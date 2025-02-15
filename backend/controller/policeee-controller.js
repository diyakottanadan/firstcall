// const Police=require('../models/police');
// exports.addPolice=(req,res)=>{
    
//         let newPolice=new Police(req.body);
//         newPolice.save().then((ewPolice)=>{
//             if(ewPolice){
//                 return res.status(200).json({message:"data added successfully"});
//             }
//             else{
//                 return res.status(500).json({message:"Internal error"});
//             }
        
//      })
// }

// exports.getProduct =(req,res)=>{
//     Police.find().then((police)=> {
//         if(police){
         
            
//             return res.status(200).json(police);
//         }

//          else{
//             return res.status(400).json({message:"internal error"});

//          }

//     })
// }
// // exports.getProductByCategory =(req,res)=>{
// //     Police.find({category:req.body.category}).then((police)=> {
// //         if(product){
         
            
// //             return res.status(200).json(product);
// //         }

// //          else{
// //             return res.status(400).json({message:"internal error"});

// //          }

// //     })
// // }