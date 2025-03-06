import 'package:dio/dio.dart';
import 'package:firstcall/pages/police/accidentreports.dart';
import 'package:flutter/material.dart';

class PoliceDashboard extends StatefulWidget {
  const PoliceDashboard({super.key});

  @override
  State<PoliceDashboard> createState() => _PoliceDashboardState();
}

class _PoliceDashboardState extends State<PoliceDashboard> {
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
            title: const Text('Accident Reports'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AccidentReports()),
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
