import 'package:dio/dio.dart';
import 'package:firstcall/pages/customer/myreports.dart';
import 'package:firstcall/pages/customer/reportaccident.dart';
import 'package:firstcall/pages/hospital/createalert.dart';
import 'package:flutter/material.dart';

class HospitalDashboard extends StatefulWidget {
  const HospitalDashboard({super.key});

  @override
  State<HospitalDashboard> createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
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
            leading: const Icon(Icons.report),
            title: const Text('Report Accident'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ReportAccident()),
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: const Icon(Icons.report_problem_sharp),
            title: const Text('My Reports'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyReport()),
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.red,
            ),
            title: const Text('Create Alert'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateAlertPage()),
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
