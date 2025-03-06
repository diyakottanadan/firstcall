import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomerDrawer extends StatefulWidget {
  const CustomerDrawer({super.key});

  @override
  State<CustomerDrawer> createState() => _CustomerDrawerState();
}

class _CustomerDrawerState extends State<CustomerDrawer> {
  // final storage = FlutterSecureStorage();
  // AuthService _authService = AuthService();
  String name = " ";
  String email = "";
  final storage = FlutterSecureStorage();
  getUser() async {
    print("Getting User");
    Map<String, String> allValues = await storage.readAll();
    var user = allValues['user'];
    print(user);
    var userMap = jsonDecode(user!);
    print(userMap);
    setState(() {
      name = userMap['name'];
      email = userMap['email'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                name[0],
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            splashColor: Colors.grey,
            onTap: () {
              Navigator.pushNamed(context, "/customer");
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Add Complaint"),
            splashColor: Colors.grey,
            onTap: () async {
              // Navigator.pushNamed(context, "/add_complaint");
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("My Complaint"),
            splashColor: Colors.grey,
            onTap: () async {
              // Navigator.pushNamed(context, "/view_my_complaint");
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text("My Profile"),
            splashColor: Colors.grey,
            onTap: () async {
              // Navigator.pushNamed(context, "/profile");
            },
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help"),
            splashColor: Colors.grey,
            onTap: () {
              print("fff");
            },
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text("Contact"),
            splashColor: Colors.grey,
            onTap: () {
              print("fff");
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            splashColor: Colors.grey,
            onTap: () async {
              await storage.delete(key: "token");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            },
          ),
        ]),
      ),
    );
  }
}
