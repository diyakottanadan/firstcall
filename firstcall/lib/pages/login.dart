import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstcall/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  UserService _userService = UserService();
  final storage = FlutterSecureStorage();

  Future<void> _login() async {
    var userdata = jsonEncode({
      "email": _emailController.text,
      "password": _passwordController.text,
    });
    print(userdata);

    try {
      final response = await _userService.loginUser(userdata);
      print(response.data);
      await storage.write(key: "user", value: jsonEncode(response.data));
      if (response.data['usertype'] == "user") {
        Navigator.pushNamedAndRemoveUntil(
            context, "/customer", (route) => false);
      } else if (response.data['usertype'] == "police") {
        Navigator.pushNamedAndRemoveUntil(context, "/police", (route) => false);
      } else if (response.data['usertype'] == "hospital") {
        Navigator.pushNamedAndRemoveUntil(
            context, "/hospital", (route) => false);
      } else if (response.data['usertype'] == "rescue") {
        Navigator.pushNamedAndRemoveUntil(context, "/rescue", (route) => false);
      } else if (response.data['usertype'] == "workshop") {
        Navigator.pushNamedAndRemoveUntil(
            context, "/workshop", (route) => false);
      } else if (response.data['usertype'] == "admin") {
        Navigator.pushNamedAndRemoveUntil(context, "/admin", (route) => false);
      }
    } on DioException catch (e) {
      print(e.response?.data);
      String message = e.response?.data["message"];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 1000),
      ));
    }

    // if (_emailController.text == "customer@gmail.com") {
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, '/studentpage', (route) => false);
    // } else if (_emailController.text == "college@gmail.com") {
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, '/collegepage', (route) => false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Container(
                //   child: Container(
                //     width: 100.0, // Set the width of the circle
                //     height: 100.0, // Set the height of the circle
                //     child: Image.asset('assets/Logo.jpg', fit: BoxFit.cover),
                //   ),
                // ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                        onPressed: () {}, child: Text("Forgot Password?"))),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _login();
                    }
                  },
                  child: const Text('Login'),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/usertype');
                        },
                        child: Text("Don't have an account? Sign Up"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
