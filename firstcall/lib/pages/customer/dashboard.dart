import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstcall/pages/customer/myreports.dart';
import 'package:firstcall/pages/customer/myworkshoprequest.dart';
import 'package:firstcall/pages/customer/reportaccident.dart';
import 'package:firstcall/pages/customer/viewworkshops.dart';
import 'package:firstcall/services/alertservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  // ShopService _service = ShopService();
  List<String> items = [];
  bool isLoading = false;
  late final Response? res;
  final storage = FlutterSecureStorage();
  String userid = "";
  AlertServices _alertServices = AlertServices();
  List<dynamic> alerts = [];
  getUser() async {
    print("Getting User");
    Map<String, String> allValues = await storage.readAll();
    var user = allValues['user'];
    print(user);
    var userMap = jsonDecode(user!);
    print(userMap);
    setState(() {
      userid = userMap['_id'];
    });
  }

  Future<void> getAletByDistrict() async {
    Map<String, String> allValues = await storage.readAll();
    var user = allValues['user'];
    print(user);
    var userMap = jsonDecode(user!);
    setState(() {
      isLoading = true;
    });
    var hospitalid = jsonEncode({"district": userMap['district']});
    try {
      final response = await _alertServices.getAlertByDistrict(hospitalid);
      print(response.data);
      setState(() {
        alerts = response.data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getAletByDistrict();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
            leading: const Icon(Icons.settings),
            title: const Text('Workshops'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewWorkshop()),
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: const Icon(Icons.settings_applications_sharp),
            title: const Text('My Workshops Request'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyWorkshopRequest()),
              );
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Text('Alerts', style: TextStyle(fontSize: 20)),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : alerts.isEmpty
                  ? Text('No alerts available')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: alerts.length,
                      itemBuilder: (context, index) {
                        var alert = alerts[index];
                        return Card(
                          color: alert['level'] == "Low"
                              ? Colors.yellow[100]
                              : alert['level'] == "Medium"
                                  ? Colors.orange[100]
                                  : Colors.red[100],
                          child: ListTile(
                            title: Text(alert['title']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Hospital: ${alert['hospitalid']['name']}'),
                                Text('Message: ${alert['message']}'),
                                Text('Level: ${alert['level']}'),
                                Text('District: ${alert['district']}'),
                                Text('City: ${alert['city']}'),
                                Text('Status: ${alert['status']}'),
                                Text(
                                    'Created At: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(alert['createdAt']))}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
