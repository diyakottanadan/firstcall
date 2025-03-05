import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstcall/services/userservice.dart';
import 'package:flutter/material.dart';

class ApproveWorkshop extends StatefulWidget {
  const ApproveWorkshop({super.key});

  @override
  State<ApproveWorkshop> createState() => _ApproveWorkshopState();
}

class _ApproveWorkshopState extends State<ApproveWorkshop> {
  UserService service = UserService();
  List<dynamic> _data = [];
  bool _isLoading = false;
  Future<void> getShops() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final Response? response = await service.getAllPendingWorkshops();

      print(response!.data);
      setState(() {
        _data = response!.data;
        _isLoading = false;
      });
    } on DioException catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e.error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print("admin shop");
    getShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Approve Workshops"),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _data.length == 0
                ? Center(
                    child: Text("No Workshops to Approved"),
                  )
                : ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      print(_data[index]["user"]);
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.workspace_premium,
                                size: 30,
                                color: Colors.blue,
                              ),
                              title: Text(
                                _data[index]["userid"]["name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              subtitle: Text(_data[index]["district"]),
                            ),
                            Text("ID Proof"),
                            Container(
                              alignment: Alignment.topLeft,
                              height: 200,
                              width: 200,
                              child: Image.memory(
                                base64Decode(
                                    _data[index]['license'].split(',')[1]),
                                fit: BoxFit.contain,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Icon(Icons.image);
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text("Email"),
                              subtitle: Text(_data[index]["userid"]["email"]),
                            ),
                            ListTile(
                              title: const Text("Phone"),
                              subtitle: Text(
                                  _data[index]["userid"]["phone"].toString()),
                            ),
                            ListTile(
                              title: const Text("Home Address"),
                              subtitle: Text(_data[index]["city"] +
                                  "\n" +
                                  _data[index]["district"] +
                                  "\n"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    onPressed: () async {
                                      var d = jsonEncode({
                                        "_id": _data[index]["_id"].toString(),
                                        "status": "active"
                                      });
                                      try {
                                        final Response? response =
                                            await service.approveWorkshop(d);
                                        print(response!.data);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.green,
                                                content:
                                                    Text("Hospital Approved"),
                                                duration: Duration(
                                                    milliseconds: 3000)));
                                        setState(() {
                                          _data.removeAt(index);
                                        });
                                      } on DioException catch (e) {
                                        print(e.error);
                                      }
                                    },
                                    child: const Text("Approve")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () async {
                                      var d = jsonEncode({
                                        "_id": _data[index]["_id"].toString(),
                                        "status": "rejected"
                                      });
                                      try {
                                        final Response? response =
                                            await service.approveWorkshop(d);
                                        print(response!.data);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.red,
                                                content:
                                                    Text("Hospital Rejected"),
                                                duration: Duration(
                                                    milliseconds: 3000)));
                                        setState(() {
                                          _data.removeAt(index);
                                        });
                                      } on DioException catch (e) {
                                        print(e.error);
                                      }
                                    },
                                    child: const Text("Reject")),
                              ],
                            )
                          ],
                        ),
                      );
                    }));
  }
}
