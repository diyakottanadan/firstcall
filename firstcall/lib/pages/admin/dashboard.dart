import 'package:dio/dio.dart';
import 'package:firstcall/pages/admin/approvehospitals.dart';
import 'package:firstcall/pages/admin/approveworkshop.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // ShopService _service = ShopService();
  List<String> items = [];
  bool isLoading = false;
  late final Response? res;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const ApproveHospitals()),
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text("Approve Hospitals"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const ApproveWorkshop()),
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text("Approve Workshops"),
          ),
        ],
      ),
    );
  }
}
