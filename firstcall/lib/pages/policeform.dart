import 'dart:convert';
//
// import 'package:demo/services/userservice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PoliceRegistrationForm extends StatefulWidget {
  const PoliceRegistrationForm({super.key});

  @override
  State<PoliceRegistrationForm> createState() => _PoliceRegistrationFormState();
}

class _PoliceRegistrationFormState extends State<PoliceRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _policeIdController = TextEditingController();
  // final _rankController = TextEditingController();
  // final _departmentController = TextEditingController();
  // final _joiningDateController = TextEditingController();
  // UserService userService = UserService();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _policeIdController.dispose();
    // _rankController.dispose();
    // _departmentController.dispose();
    // _joiningDateController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, show a success message
      var userdata = jsonEncode({
        "name": _nameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "password": _passwordController.text,
        "police_id": _policeIdController.text,
        // "rank": _rankController.text,
        // "department": _departmentController.text,
        // "joining_date": _joiningDateController.text,
        "usertype": "police",
      });
      print(userdata);
      // try {
      //   final response = await userService.registerUser(userdata);
      //   print(response.data);
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Registration Successful!')),
      //   );
      // } on DioException catch (e) {
      //   print(e.response!.data);
      // }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Registering User')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Police Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
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

              // Phone Field
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

              // Police ID (Badge Number) Field
              TextFormField(
                controller: _policeIdController,
                decoration: InputDecoration(labelText: 'Police ID (Badge Number)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Police ID is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Rank Field
              // TextFormField(
              //   controller: _rankController,
              //   decoration: InputDecoration(labelText: 'Rank'),
              //   validator: (value) {
              //     if (value == null || value.trim().isEmpty) {
              //       return 'Rank is required';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: 16),
              //
              // // Department Field
              // TextFormField(
              //   controller: _departmentController,
              //   decoration: InputDecoration(labelText: 'Department'),
              //   validator: (value) {
              //     if (value == null || value.trim().isEmpty) {
              //       return 'Department is required';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: 16),
              //
              // // Joining Date Field
              // TextFormField(
              //   controller: _joiningDateController,
              //   decoration: InputDecoration(labelText: 'Joining Date'),
              //   keyboardType: TextInputType.datetime,
              //   validator: (value) {
              //     if (value == null || value.trim().isEmpty) {
              //       return 'Joining Date is required';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: 24),

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
