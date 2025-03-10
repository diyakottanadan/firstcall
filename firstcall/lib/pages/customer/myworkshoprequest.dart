import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstcall/services/accidentservice.dart';
import 'package:firstcall/services/workshopservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyWorkshopRequest extends StatefulWidget {
  const MyWorkshopRequest({super.key});

  @override
  State<MyWorkshopRequest> createState() => _MyWorkshopRequestState();
}

class _MyWorkshopRequestState extends State<MyWorkshopRequest> {
  WorkshopService _accidentService = WorkshopService();
  List<dynamic> reports = [];
  var userid;
  String policeid = "";
  final storage = FlutterSecureStorage();
  bool isLoading = false;
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

  Future<void> getReportsByUserid() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> allValues = await storage.readAll();
    var user = allValues['user'];
    print(user);
    var userMap = jsonDecode(user!);
    print(userMap);
    var userdata = jsonEncode({"userid": userMap['_id']});
    try {
      final response =
          await _accidentService.getWorkshopRequestByUserId(userdata);
      print(response.data);

      setState(() {
        reports = response.data;
        isLoading = false;
      });
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error occurred,please try again"),
        duration: Duration(milliseconds: 300),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getReportsByUserid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Reports'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : reports.isEmpty
                ? const Center(
                    child: Text("No Reports Found"),
                  )
                : ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(reports[index]['subject']),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        height: 200,
                                        width: 200,
                                        child: Image.memory(
                                          base64Decode(reports[index]['image']
                                              .split(',')[1]),
                                          fit: BoxFit.contain,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Icon(Icons.image);
                                          },
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "Location: ${reports[index]['location']}"),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "Workshop: ${reports[index]['workshopid']['name']}"),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "${reports[index]['workshopid']['phone'].toString()}"),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "${reports[index]['content']}"),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "Status: ${reports[index]['status']}"),
                                      ),
                                      reports[index]['status'] != "Pending"
                                          ? Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Reply: ${reports[index]['reply']}"),
                                            )
                                          : Container(),

                                      //Text("Date: ${reports[index]['date']}"),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          title: Text(reports[index]['subject']),
                          subtitle: Text(reports[index]['location']),
                          trailing: Text(
                            reports[index]['status'],
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      );
                    },
                  ));
  }
}
