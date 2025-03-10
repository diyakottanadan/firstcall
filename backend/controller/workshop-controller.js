const WorkshopRequest = require("../models/workshoprequest");
const User = require("../models/user");
const Workshop = require("../models/workshop");


exports.viewWorkshopUserByDistrict = (req, res) => {
    Workshop.find({ district: req.body.district, status: "active" }).populate('userid').then((user) => {
        if (user) {
            return res.status(200).json(user);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}

exports.addWorkshopRequest = (req, res) => {
    //console.log(req.body);
    let newWorkshopWorkshopRequest = new WorkshopRequest(req.body);
    newWorkshopWorkshopRequest.save().then((newWorkshopWorkshopRequest) => {
        if (newWorkshopWorkshopRequest) {
            return res.status(200).json(newWorkshopWorkshopRequest);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}


exports.getWorkshopRequestByUserId = (req, res) => {
    console.log(req.body.userid);
   WorkshopRequest.find({ userid: req.body.userid }).populate('workshopid').then((Request) => {
        if (Request) {
            return res.status(200).json(Request);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}


exports.getRequestByWorkshipId = (req, res) => {
    console.log(req.body);
   WorkshopRequest.find({ workshopid: req.body.workshopid }).populate('userid').then((WorkshopWorkshopRequest) => {
        if (WorkshopWorkshopRequest) {
            return res.status(200).json(WorkshopWorkshopRequest);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}

exports.replyToWorkshopRequest = (req, res) => {
   WorkshopRequest.findOneAndUpdate({ _id: req.body._id }, { reply: req.body.reply, status: "Replied" }).then((reply) => {
        if (reply) {
            return res.status(200).json(reply);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}