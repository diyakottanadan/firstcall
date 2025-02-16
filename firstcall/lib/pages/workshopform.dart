import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firstcall/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WorkshopFormPage extends StatefulWidget {
  const WorkshopFormPage({super.key});

  @override
  State<WorkshopFormPage> createState() => _WorkshopFormPageState();
}

class _WorkshopFormPageState extends State<WorkshopFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _hospitalNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _hospitalTypeController = TextEditingController();
  final _numberOfBedsController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _placeController = TextEditingController();
  XFile? _imageFile;
  bool _isLoading = false;
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
  String? district = "Alappuzha";
  UserService userService = UserService();

  Future<void> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  void dispose() {
    _hospitalNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _licenseNumberController.dispose();
    _addressController.dispose();
    _hospitalTypeController.dispose();
    _numberOfBedsController.dispose();
    _emergencyContactController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Form is valid, process the data
      List<String>? s = _imageFile?.path.toString().split("/");
      final bytes = await File(_imageFile!.path).readAsBytes();
      final base64 = base64Encode(bytes);
      var pic = "data:image/${s![s.length - 1].split(".")[1]};base64,$base64";
      var hospitalData = jsonEncode({
        "name": _hospitalNameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "password": _passwordController.text,
        "license": pic,
        "usertype": "workshop",
        "city": _placeController.text,
        "district": district,
      });
      print(hospitalData);
      try {
        final response = await userService.registerUser(hospitalData);
        print(response.data);
        setState(() {
          _isLoading = false;
        });
        _showSuccessDialog();
      } on DioException catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e.response);
        if (e.response?.statusCode == 400) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email already exists'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred. Please try again later.'),
            ),
          );
        }
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Successful'),
          content: Text('Your workshop has been registered successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workshop Registration'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Hospital Name Field
                      TextFormField(
                        controller: _hospitalNameController,
                        decoration: InputDecoration(labelText: 'Workshop Name'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Phone Number Field
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          }
                          final phoneRegex = RegExp(r'^\d{10}$');
                          if (!phoneRegex.hasMatch(value)) {
                            return 'Enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Confirm Password Field
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Confirm password is required';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16),

                      // Place Field
                      TextFormField(
                        controller: _placeController,
                        decoration: InputDecoration(labelText: 'Place'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Place is required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: district,
                        decoration: const InputDecoration(
                          labelText: 'District',
                          border: OutlineInputBorder(),
                        ),
                        items: items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            district = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your district';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Upload Proof
                      GestureDetector(
                        onTap: getImageFromGallery,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.image, color: Colors.black),
                              SizedBox(width: 10),
                              Text('Upload Proof',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Display selected image
                      Center(
                        child: _imageFile == null
                            ? Text('No image selected')
                            : Image.file(
                                File(_imageFile!.path),
                                width: 360,
                                height: 240,
                              ),
                      ),
                      SizedBox(height: 16),

                      // Submit Button
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Register'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
