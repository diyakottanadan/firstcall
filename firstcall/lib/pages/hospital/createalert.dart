import 'dart:convert';

import 'package:firstcall/services/alertservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreateAlertPage extends StatefulWidget {
  @override
  _CreateAlertPageState createState() => _CreateAlertPageState();
}

class _CreateAlertPageState extends State<CreateAlertPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();
  String _selectedLevel = 'Low';
  AlertServices _alertServices = AlertServices();
  final storage = FlutterSecureStorage();
  bool isLoading = false;
  String userid = "";
  List<dynamic> alerts = [];
  getUser() async {
    print("Getting User");
    Map<String, String> allValues = await storage.readAll();
    var user = allValues['user'];
    print(user);
    var userMap = jsonDecode(user!);
    print(userMap);
    setState(() {
      userid = userMap['_id'];
    });
  }

  Future<void> getAletByHospitalId() async {
    Map<String, String> allValues = await storage.readAll();
    var user = allValues['user'];
    print(user);
    var userMap = jsonDecode(user!);
    setState(() {
      isLoading = true;
    });
    var hospitalid = jsonEncode({"hospitalid": userMap['_id']});
    try {
      final response = await _alertServices.getAlertByHospitalId(hospitalid);
      print(response.data);
      setState(() {
        alerts = response.data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  final List<String> items = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad'
  ];

  Future<void> submitAlert() async {
    var alertdata = jsonEncode({
      "hospitalid": userid,
      "title": _titleController.text,
      "message": _messageController.text,
      "level": _selectedLevel,
      "district": _districtController.text,
      "city": _cityController.text
    });
    try {
      final response = await _alertServices.addAlert(alertdata);
      print(response.data);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Alert Created"),
        duration: Duration(milliseconds: 3000),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getAletByHospitalId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Alert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Message'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedLevel,
                decoration: InputDecoration(labelText: 'Level'),
                items: ['Low', 'Medium', 'High'].map((String level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedLevel = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a level';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: items.contains(_districtController.text)
                    ? _districtController.text
                    : null,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _districtController.text = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'District'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a district';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    submitAlert();
                  }
                },
                child: Text('Submit'),
              ),
              Text(
                'Alerts:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : alerts.isEmpty
                      ? Text('No alerts available')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: alerts.length,
                          itemBuilder: (context, index) {
                            var alert = alerts[index];
                            return Card(
                              child: ListTile(
                                title: Text(alert['title']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Message: ${alert['message']}'),
                                    Text('Level: ${alert['level']}'),
                                    Text('District: ${alert['district']}'),
                                    Text('City: ${alert['city']}'),
                                    Text('Status: ${alert['status']}'),
                                    Text('Created At: ${alert['createdAt']}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}
