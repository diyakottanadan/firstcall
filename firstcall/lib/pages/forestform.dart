import 'dart:convert';
//
// import 'package:demo/services/userservice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ForestFormPage extends StatefulWidget {
  const ForestFormPage({super.key});

  @override
  State<ForestFormPage> createState() => _ForestFormPageState();
}

class _ForestFormPageState extends State<ForestFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _forestNameController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _locationController = TextEditingController();
  final _areaSizeController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // UserService userService = UserService();

  @override
  void dispose() {
    _forestNameController.dispose();
    _licenseNumberController.dispose();
    _locationController.dispose();
    _areaSizeController.dispose();
    _contactPersonController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, show a success message
      var forestData = jsonEncode({
        "forest_name": _forestNameController.text,
        "license_number": _licenseNumberController.text,
        "location": _locationController.text,
        "area_size": _areaSizeController.text,
        "contact_person": _contactPersonController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "password": _passwordController.text,
        "usertype": "forest", // Indicating it's a forest registration
      });
      print(forestData);
      // try {
      //   // final response = await userService.registerUser(forestData);
      //   print(response.data);
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Forest Registration Successful!')),
      //   );
      // } on DioException catch (e) {
      //   print(e.response!.data);
      // }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during Forest Registration')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forest Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Forest Name Field
              TextFormField(
                controller: _forestNameController,
                decoration: InputDecoration(labelText: 'Forest Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Forest name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // License Number Field
              TextFormField(
                controller: _licenseNumberController,
                decoration: InputDecoration(labelText: 'License Number'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'License number is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Location Field
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Location is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Area Size Field (in square kilometers)
              TextFormField(
                controller: _areaSizeController,
                decoration: InputDecoration(labelText: 'Area Size (in sq km)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Area size is required';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Contact Person Field
              TextFormField(
                controller: _contactPersonController,
                decoration: InputDecoration(labelText: 'Contact Person'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Contact person is required';
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

              // Phone Field
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
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
                decoration: InputDecoration(labelText: 'Confirm Password'),
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
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
