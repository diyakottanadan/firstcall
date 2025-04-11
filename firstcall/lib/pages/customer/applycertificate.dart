import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firstcall/services/accidentservice.dart';
import 'package:firstcall/services/certificateservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class ApplyCertificatePage extends StatefulWidget {
  @override
  _ApplyCertificatePageState createState() => _ApplyCertificatePageState();
}

class _ApplyCertificatePageState extends State<ApplyCertificatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _adhaarController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _muncipalityController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final _locationController = TextEditingController();
  AccidentService _accidentService = AccidentService();
  CertificateService _certificateService = CertificateService();
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
    police.clear();
    var district = jsonEncode({"district": _locationController.text});
    final response;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    _adhaarController.dispose();
    _purposeController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _villageController.dispose();
    _muncipalityController.dispose();
    _occupationController.dispose();
    _phoneNumberController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      print("Form submitted successfully");
      if (_image != null) {
        print("Image path: ${_image!.path}");
        setState(() {
          isLoading = true;
        });
        List<String>? s = _image?.path.toString().split("/");
        final bytes = await File(_image!.path).readAsBytes();
        final base64 = base64Encode(bytes);
        var pic = "data:image/${s![s.length - 1].split(".")[1]};base64,$base64";
        var accidentData = jsonEncode({
          "userid": userid,
          "policeid": policeid,
          "adhaar": pic,
          "purpose": _purposeController.text,
          "full_name": _fullNameController.text,
          "address": _addressController.text,
          "village": _villageController.text,
          "muncipality": _muncipalityController.text,
          "occupation": _occupationController.text,
          "phone_number": _phoneNumberController.text,
          "remarks": _remarksController.text
        });
        try {
          final response =
              await _certificateService.addCertificate(accidentData);
          print(response.data);
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Certificate applied successfully"),
            duration: Duration(milliseconds: 2000),
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select an image"),
          duration: Duration(milliseconds: 2000),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply for Certificate'),
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
                  children: [
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
                          police.clear();
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
                      decoration:
                          const InputDecoration(labelText: 'Police Station'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a service provider';
                        }
                        return null;
                      },
                    ),
                    _image == null
                        ? const Text('No image selected.')
                        : Image.file(File(_image!.path)),
                    TextButton(
                      onPressed: _pickImage,
                      child: const Text('Pick Adhaar Image'),
                    ),
                    TextFormField(
                      controller: _purposeController,
                      decoration: InputDecoration(labelText: 'Purpose'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Purpose is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(labelText: 'Full Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Full Name is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Address is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _villageController,
                      decoration: InputDecoration(labelText: 'Village'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Village is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _muncipalityController,
                      decoration: InputDecoration(labelText: 'Municipality'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Municipality is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _occupationController,
                      decoration: InputDecoration(labelText: 'Occupation'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Occupation is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Number is required';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _remarksController,
                      decoration: InputDecoration(labelText: 'Remarks'),
                      maxLines: 3,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
