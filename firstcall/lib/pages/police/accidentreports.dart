import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstcall/services/accidentservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccidentReports extends StatefulWidget {
  const AccidentReports({super.key});

  @override
  State<AccidentReports> createState() => _AccidentReportsState();
}

class _AccidentReportsState extends State<AccidentReports> {
  AccidentService _accidentService = AccidentService();
  TextEditingController _replyController = TextEditingController();
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

  Future<void> _replyToReport(var id) async {
    if (_replyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Reply cannot be empty"),
        duration: Duration(milliseconds: 3000),
        backgroundColor: Colors.red,
      ));
      return;
    } else {
      var replydata = jsonEncode({"_id": id, "reply": _replyController.text});
      print(replydata);
      try {
        final response =
            await _accidentService.replyToAccidentReport(replydata);
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Reply submitted successfully"),
          duration: Duration(milliseconds: 3000),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pop();
        getReportsByUserid();
      } on DioException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error occurred,please try again"),
          duration: Duration(milliseconds: 300),
        ));
      }
    }
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
    var userdata = jsonEncode({"policeid": userMap['_id']});
    try {
      final response =
          await _accidentService.getAccidentReportByPoliceId(userdata);
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
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              "User Name : ${reports[index]['userid']['name']}"),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              "Phone : ${reports[index]['userid']['phone'].toString()}"),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              "${reports[index]['content']}"),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              "Status: ${reports[index]['status']}"),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        reports[index]['status'] == "Pending"
                                            ? Column(
                                                children: [
                                                  TextField(
                                                    controller:
                                                        _replyController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Reply',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    maxLines: 3,
                                                    onChanged: (value) {
                                                      // Handle the reply input
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      _replyToReport(
                                                          reports[index]
                                                              ['_id']);
                                                    },
                                                    child: Text('Submit'),
                                                  ),
                                                ],
                                              )
                                            : Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    "Reply: ${reports[index]['reply']}"),
                                              ),

                                        //Text("Date: ${reports[index]['date']}"),
                                      ],
                                    ),
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
                          trailing: Text(reports[index]['status']),
                        ),
                      );
                    },
                  ));
  }
}
