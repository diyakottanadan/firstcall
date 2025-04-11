const Certificate = require('../models/certificate');

//add certificate
exports.addCertificate = (req, res) => {
    let newCertificate = new Certificate(req.body);
    newCertificate.save().then((newCertificate) => {
        if (newCertificate) {
            return res.status(200).json(newCertificate);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}
//get certificate by policeid
exports.getCertificateByPoliceId = (req, res) => {
    console.log(req.body.policeid);
    Certificate.find({ policeid: req.body.policeid }).populate('userid').then((certificate) => {
        if (certificate) {
            return res.status(200).json(certificate);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}
//get certificate by userid
exports.getCertificateByUserId = (req, res) => {
    Certificate.find({ userid: req.body.userid }).populate('policeid').then((certificate) => {
        if (certificate) {
            return res.status(200).json(certificate);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    }
    )
}
//get certificate by id
exports.getCertificateById = (req, res) => {
    Certificate.findById(req.body.id).populate('userid').populate('policeid').then((certificate) => {
        if (certificate) {
            return res.status(200).json(certificate);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}

//update certificate status
exports.updateCertificateStatus = (req, res) => {
    Certificate.updateOne({_id:req.body._id},{$set:{status:req.body.status}}).then((certificate) => {
        if (certificate) {
            return res.status(200).json(certificate);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}