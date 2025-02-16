import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ForestDashboard extends StatefulWidget {
  const ForestDashboard({super.key});

  @override
  State<ForestDashboard> createState() => _ForestDashboardState();
}

class _ForestDashboardState extends State<ForestDashboard> {
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
        ],
      ),
    );
  }
}
