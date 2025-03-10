import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firstcall/services/accidentservice.dart';
import 'package:firstcall/services/workshopservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class SendWorkshopRequest extends StatefulWidget {
  const SendWorkshopRequest(
      {super.key, required this.workshopid, required this.name});
  final String workshopid, name;

  @override
  State<SendWorkshopRequest> createState() => _SendWorkshopRequestState();
}

class _SendWorkshopRequestState extends State<SendWorkshopRequest> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _contentController = TextEditingController();
  final _locationController = TextEditingController();
  WorkshopService _accidentService = WorkshopService();
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
      "workshopid": widget.workshopid,
      "image": pic
    });
    try {
      final response = await _accidentService.addWorkshopRequest(accidentData);
      print(response.data);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Requested successfully"),
        duration: Duration(milliseconds: 3000),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context);
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
        title: const Text('Workshop Request'),
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
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(labelText: 'Location'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: widget.name,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Workshop'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
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
