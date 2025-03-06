const AccidentReport = require("../models/accidentreport");
const User = require("../models/user");
const Police = require("../models/police");

exports.addAccidentReport = (req, res) => {
    //console.log(req.body);
    let newAccidentReport = new AccidentReport(req.body);
    newAccidentReport.save().then((newAccidentReport) => {
        if (newAccidentReport) {
            return res.status(200).json(newAccidentReport);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}

//get accident report by userid
exports.getAccidentReportByUserId = (req, res) => {
    console.log(req.body.userid);
    AccidentReport.find({ userid: req.body.userid }).populate('policeid').then((accidentReport) => {
        if (accidentReport) {
            return res.status(200).json(accidentReport);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}

//get accident report by policeid
exports.getAccidentReportByPoliceId = (req, res) => {
    console.log(req.body);
    AccidentReport.find({ policeid: req.body.policeid }).populate('userid').then((accidentReport) => {
        if (accidentReport) {
            return res.status(200).json(accidentReport);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}

//reply to accident report
exports.replyToAccidentReport = (req, res) => {
    AccidentReport.findOneAndUpdate({ _id: req.body._id }, { reply: req.body.reply, status: "Replied" }).then((reply) => {
        if (reply) {
            return res.status(200).json(reply);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}

//get police by district
exports.getPoliceByDistrict = (req, res) => {
    console.log(req.body.district);
    Police.find({ district: req.body.district }).populate('userid').populate("userid").then((police) => {
        if (police) {
            
            return res.status(200).json(police);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}



