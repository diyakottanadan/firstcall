import 'package:dio/dio.dart';
import 'package:firstcall/pages/police/accidentreports.dart';
import 'package:firstcall/pages/workshop/request.dart';
import 'package:flutter/material.dart';

class WorkshopDashboard extends StatefulWidget {
  const WorkshopDashboard({super.key});

  @override
  State<WorkshopDashboard> createState() => _WorkshopDashboardState();
}

class _WorkshopDashboardState extends State<WorkshopDashboard> {
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
            leading: const Icon(Icons.work_history_sharp),
            title: const Text('Requests'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Requests()),
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
