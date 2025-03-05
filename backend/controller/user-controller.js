const User = require('../models/user');
const Hospital = require('../models/hospital');
const Police = require('../models/police');
const Rescue = require('../models/rescue');
const Forest = require('../models/forest');
const Workshop = require('../models/workshop');
exports.Register = (req, res) => {
    console.log(req.body);
    User.findOne({ email: req.body.email }).then((user) => {
        if (user) {
            return res.status(400).json({ message: "User already exists" });
        }
        let newUser = new User(req.body);
        newUser.save().then((newUser) => {
            if (newUser) {
                req.body.userid = newUser._id;
                if (req.body.usertype == "hospital") {
                    let newHospital = new Hospital(req.body);
                    newHospital.save().then((newHospital) => {
                        if (newHospital) {
                            return res.status(200).json(newHospital);
                        }
                        else {
                            return res.status(500).json({ message: "Internal error" });
                        }
                    })
                }
                else if (req.body.usertype == "police") {
                    let newPolice = new Police(req.body);
                    newPolice.save().then((newPolice) => {
                        if (newPolice) {
                            return res.status(200).json(newPolice);
                        }
                        else {
                            return res.status(500).json({ message: "Internal error" });
                        }
                    })
                }
                else if (req.body.usertype == "rescue") {
                    let newRescue = new Rescue(req.body);
                    newRescue.save().then((newRescue) => {
                        if (newRescue) {
                            return res.status(200).json(newRescue);
                        }
                        else {
                            return res.status(500).json({ message: "Internal error" });
                        }
                    })
                }
                else if (req.body.usertype == "forest") {
                    let newForest = new Forest(req.body);
                    newForest.save().then((newForest) => {
                        if (newForest) {
                            return res.status(200).json(newForest);
                        }
                        else {
                            return res.status(500).json({ message: "Internal error" });
                        }
                    })
                }
                else if (req.body.usertype == "workshop") {
                    let newWorkshop = new Workshop(req.body);
                    newWorkshop.save().then((newWorkshop) => {
                        if (newWorkshop) {
                            return res.status(200).json(newWorkshop);
                        }
                        else {
                            return res.status(500).json({ message: "Internal error" });
                        }
                    })
                }
                else if (req.body.usertype == "user") {
                    return res.status(200).json(newUser);
                }
            }
            else {
                return res.status(500).json({ message: "Internal error" });
            }
        })
    })
}

exports.login = (req, res) => {
    User.findOne({ email: req.body.email }).then((user) => {
        if (user) {
            User.findOne({ email: req.body.email, password: req.body.password }).then((exist) => {
                if (exist) {
                    return res.status(200).json(exist);
                }
                else {
                    return res.status(400).json({ message: "invalid password" });
                }
            })
        }
        else {
            return res.status(400).json({ message: "user not found" });
        }
    })
}

exports.getAllPendingHospital = (req,res)=>{
    Hospital.find({status:"pending"}).populate('userid').then((hospital)=>{
        if(hospital){
            return res.status(200).json(hospital);
        }
        else{
            return res.status(500).json({message:"Internal error"});
        }
    })
}

//get all pending workshop
exports.getAllPendingWorkshop = (req,res)=>{
    Workshop.find({status:"pending"}).populate('userid').then((workshop)=>{
        if(workshop){
            return res.status(200).json(workshop);
        }
        else{
            return res.status(500).json({message:"Internal error"});
        }
    })
}

//approve hospital
exports.approveHospital = (req,res)=>{
    Hospital.findByIdAndUpdate(req.body._id,{status:req.body.status}).then((hospital)=>{
        if(hospital){
            return res.status(200).json(hospital);
        }
        else{
            return res.status(500).json({message:"Internal error"});
        }
    })
}

//approve workshop
exports.approveWorkshop = (req,res)=>{
    Workshop.findByIdAndUpdate(req.body._id,{status:req.body.status}).then((workshop)=>{
        if(workshop){
            return res.status(200).json(workshop);
        }
        else{
            return res.status(500).json({message:"Internal error"});
        }
    })
}