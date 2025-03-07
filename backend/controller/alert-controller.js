const Alert = require('../models/alert');

//add alert
exports.addAlert = (req, res) => {
    let newAlert = new Alert(req.body);
    newAlert.save().then((newAlert) => {
        if (newAlert) {
            return res.status(200).json(newAlert);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}
//get alert by hospitalid
exports.getAlertByHospitalId = (req, res) => {
    console.log(req.body.hospitalid);
    Alert.find({ hospitalid: req.body.hospitalid }).then((alert) => {
        if (alert) {
            return res.status(200).json(alert);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}
//get alert by district
exports.getAlertByDistrict = (req, res) => {
    console.log(req.body.district);
    Alert.find({ district: req.body.district }).populate('hospitalid').then((alert) => {
        if (alert) {
            return res.status(200).json(alert);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}

//change alert status
exports.changeAlertStatus = (req, res) => {
    Alert.findOneAndUpdate({ _id: req.body._id }, { status: req.body.status }).then((alert) => {
        if (alert) {
            return res.status(200).json(alert);
        }
        else {
            return res.status(500).json({ message: "Internal error" });
        }
    })
}

