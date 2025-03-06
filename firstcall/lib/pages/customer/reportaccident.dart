import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firstcall/services/accidentservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class ReportAccident extends StatefulWidget {
  const ReportAccident({super.key});

  @override
  State<ReportAccident> createState() => _ReportAccidentState();
}

class _ReportAccidentState extends State<ReportAccident> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _contentController = TextEditingController();
  final _locationController = TextEditingController();
  AccidentService _accidentService = AccidentService();
  XFile? _image;
  var userid;
  String policeid = "";
  final storage = FlutterSecureStorage();
  List<dynamic> police = [];
  bool isLoading = false;

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

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> getPoliceByDistrict() async {
    var district = jsonEncode({"district": _locationController.text});
    try {
      final response = await _accidentService.getPoliceByDistrict(district);
      print(response.data);
      if (mounted) {
        setState(() {
          police = response.data;
        });
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error occurred,please try again"),
        duration: Duration(milliseconds: 300),
      ));
    }
  }

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });
    List<String>? s = _image?.path.toString().split("/");
    final bytes = await File(_image!.path).readAsBytes();
    final base64 = base64Encode(bytes);
    var pic = "data:image/${s![s.length - 1].split(".")[1]};base64,$base64";
    var accidentData = jsonEncode({
      "subject": _subjectController.text,
      "content": _contentController.text,
      "location": _locationController.text,
      "userid": userid,
      "policeid": policeid,
      "image": pic
    });
    try {
      final response = await _accidentService.addAccidentReport(accidentData);
      print(response.data);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Accident reported successfully"),
        duration: Duration(milliseconds: 3000),
        backgroundColor: Colors.green,
      ));
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error occurred,please try again"),
        duration: Duration(milliseconds: 300),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Accident'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      controller: _subjectController,
                      decoration: const InputDecoration(labelText: 'Subject'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a subject';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _contentController,
                      maxLines: 5,
                      decoration: const InputDecoration(labelText: 'Content'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter content';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: items.contains(_locationController.text)
                          ? _locationController.text
                          : null,
                      items: items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _locationController.text = value!;
                        });
                        getPoliceByDistrict();
                      },
                      decoration: const InputDecoration(labelText: 'District'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a district';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: police.isNotEmpty &&
                              police.any((p) => p['userid']['_id'] == userid)
                          ? userid
                          : null,
                      items: police.map((dynamic police) {
                        return DropdownMenuItem<String>(
                          value: police['userid']['_id'],
                          child: Text(
                              police['userid']['name'] + ", " + police['city']),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          policeid = value!;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Police'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a police station';
                        }
                        return null;
                      },
                    ),
                    _image == null
                        ? const Text('No image selected.')
                        : Image.file(File(_image!.path)),
                    TextButton(
                      onPressed: _pickImage,
                      child: const Text('Pick Image'),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _submit();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _contentController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
