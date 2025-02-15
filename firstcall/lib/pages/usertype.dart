import 'package:flutter/material.dart';

class UserTypePage extends StatefulWidget {
  const UserTypePage({super.key});

  @override
  State<UserTypePage> createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 600,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text("User Registration"),
                    onTap: () {
                      Navigator.pushNamed(context, '/user_registration');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text("Police Registration"),
                    onTap: () {
                      Navigator.pushNamed(context, '/police_registration');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text("Hospital Registration"),
                    onTap: () {
                      Navigator.pushNamed(context, '/hospital_registration');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text("Rescue Team Registration"),
                    onTap: () {
                      Navigator.pushNamed(context, '/rescue_registration');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text("Workshop Registration"),
                    onTap: () {
                      Navigator.pushNamed(context, '/workshop_registration');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text("Forest Department Registration"),
                    onTap: () {
                      Navigator.pushNamed(context, '/forest_registration');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
