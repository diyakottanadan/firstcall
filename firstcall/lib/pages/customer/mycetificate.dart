import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstcall/pages/customer/mycertificatesingle.dart';
import 'package:firstcall/services/certificateservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyCertificate extends StatefulWidget {
  const MyCertificate({super.key});

  @override
  State<MyCertificate> createState() => _MyCertificateState();
}

class _MyCertificateState extends State<MyCertificate> {
  CertificateService _certificateService = CertificateService();
  List<dynamic> certificates = [];
  var userid;
  final storage = FlutterSecureStorage();
  bool isLoading = false;
  Future<void> getCertificateByUSerid() async {
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
          await _certificateService.getCertificateByUserId(userdata);
      print(response.data);

      setState(() {
        certificates = response.data;
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
    getCertificateByUSerid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Certificate"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : certificates.isEmpty
              ? const Center(
                  child: Text("No Certificate"),
                )
              : ListView.builder(
                  itemCount: certificates.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => MyCertificateSingle(
                                    id: certificates[index]['_id'])),
                          );
                        },
                        title: Text(certificates[index]['policeid']['name']),
                        subtitle: Text(certificates[index]['purpose']),
                      ),
                    );
                  },
                ),
    );
  }
}
