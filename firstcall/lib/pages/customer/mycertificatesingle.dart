import 'dart:convert';

import 'package:firstcall/services/certificateservice.dart';
import 'package:flutter/material.dart';

class MyCertificateSingle extends StatefulWidget {
  const MyCertificateSingle({super.key, this.id});
  final String? id;

  @override
  State<MyCertificateSingle> createState() => _MyCertificateSingleState();
}

class _MyCertificateSingleState extends State<MyCertificateSingle> {
  CertificateService _certificateService = CertificateService();
  dynamic certificate = {};
  bool isLoading = false;
  getCertificateById() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _certificateService.getCertificateById(widget.id!);
      print(response.data);

      setState(() {
        certificate = response.data;
        isLoading = false;
      });
    } catch (e) {
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
    getCertificateById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Certificate"),
        actions: [],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(certificate['policeid']['name']),
                          subtitle:
                              Text(certificate['policeid']['phone'].toString()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(20),
                          child: Text("Certiicate Details"),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: 200,
                          width: 200,
                          child: Image.memory(
                            base64Decode(certificate['adhaar'].split(',')[1]),
                            fit: BoxFit.contain,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Icon(Icons.image);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text("Purpose"),
                          subtitle: Text(certificate['purpose']),
                        ),
                        ListTile(
                          title: Text("Full Name"),
                          subtitle: Text(certificate['full_name']),
                        ),
                        ListTile(
                          title: Text("Address"),
                          subtitle: Text(certificate['address']),
                        ),
                        ListTile(
                          title: Text("Phone Number"),
                          subtitle:
                              Text(certificate['phone_number'].toString()),
                        ),
                        ListTile(
                          title: Text("Village"),
                          subtitle: Text(certificate['village']),
                        ),
                        ListTile(
                          title: Text("Muncipality"),
                          subtitle: Text(certificate['muncipality']),
                        ),
                        ListTile(
                          title: Text("Occupation"),
                          subtitle: Text(certificate['occupation']),
                        ),
                        ListTile(
                          title: Text("Remarks"),
                          subtitle: Text(certificate['remarks'] ?? ""),
                        ),
                        ListTile(
                          title: Text("Satus"),
                          subtitle: Text(certificate['status'] ?? ""),
                        ),
                        ListTile(
                          title: Text("Applied On"),
                          subtitle: Text(
                            certificate['createdAt'] != null
                                ? DateTime.parse(certificate['createdAt'])
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0] // Format as YYYY-MM-DD
                                : "",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
