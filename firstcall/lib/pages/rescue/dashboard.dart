import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RescueDashboard extends StatefulWidget {
  const RescueDashboard({super.key});

  @override
  State<RescueDashboard> createState() => _RescueDashboardState();
}

class _RescueDashboardState extends State<RescueDashboard> {
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
