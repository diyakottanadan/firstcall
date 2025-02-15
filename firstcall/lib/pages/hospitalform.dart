import 'dart:convert';

// import 'package:demo/services/userservice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HospitalFormPage extends StatefulWidget {
  const HospitalFormPage({super.key});

  @override
  State<HospitalFormPage> createState() => _HospitalFormPageState();
}

class _HospitalFormPageState extends State<HospitalFormPage> {
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
  // UserService userService = UserService();

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
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, show a success message
      var hospitalData = jsonEncode({
        "hospital_name": _hospitalNameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "password": _passwordController.text,
        "license_number": _licenseNumberController.text,
        "address": _addressController.text,
        "hospital_type": _hospitalTypeController.text,
        "number_of_beds": _numberOfBedsController.text,
        "emergency_contact": _emergencyContactController.text,
        "usertype": "hospital",
      });
      print(hospitalData);
      // try {
      //   final response = await userService.registerUser(hospitalData);
      //   print(response.data);
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Hospital Registration Successful!')),
      //   );
      // } on DioException catch (e) {
      //   print(e.response!.data);
      // }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Registering Hospital')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Hospital Name Field
              TextFormField(
                controller: _hospitalNameController,
                decoration: InputDecoration(labelText: 'Hospital Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Hospital Name is required';
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

              // Address Field
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Hospital Address'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Hospital Type Field
              TextFormField(
                controller: _hospitalTypeController,
                decoration: InputDecoration(labelText: 'Type of Hospital'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Hospital type is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Number of Beds Field
              TextFormField(
                controller: _numberOfBedsController,
                decoration: InputDecoration(labelText: 'Number of Beds'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Number of beds is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Emergency Contact Field
              TextFormField(
                controller: _emergencyContactController,
                decoration: InputDecoration(labelText: 'Emergency Contact'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Emergency contact is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Register Hospital'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
