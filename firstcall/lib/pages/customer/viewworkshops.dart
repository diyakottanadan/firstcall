import 'package:dio/dio.dart';
import 'package:firstcall/pages/customer/sendworkshoprequest.dart';
import 'package:firstcall/services/workshopservice.dart';
import 'package:flutter/material.dart';

class ViewWorkshop extends StatefulWidget {
  const ViewWorkshop({super.key});

  @override
  State<ViewWorkshop> createState() => _ViewWorkshopState();
}

class _ViewWorkshopState extends State<ViewWorkshop> {
  final List<String> items = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad'
  ];
  String? district;
  WorkshopService _workshopService = WorkshopService();
  List<dynamic> workshops = [];
  Future<void> getWorkshops() async {
    try {
      print(district);
      final response =
          await _workshopService.viewWorkshopUserByDistrict(district!);
      print(response.data);
      setState(() {
        workshops = response.data;
      });
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error occurred,please try again"),
        duration: Duration(milliseconds: 300),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Workshops"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField<String>(
                value: district,
                decoration: InputDecoration(
                    labelText: 'Select District',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    district = newValue;
                  });
                  getWorkshops();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your district';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            workshops.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: workshops.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SendWorkshopRequest(
                                        workshopid: workshops[index]['userid']
                                            ['_id'],
                                        name: workshops[index]['userid']
                                            ['name'])));
                          },
                          title: Text(workshops[index]['userid']['name']),
                          subtitle: Text(workshops[index]['district'] +
                              ", " +
                              workshops[index]['city']),
                          //trailing: Text(workshops[index]['phone']),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No workshops available"),
                  )
          ],
        ),
      ),
    );
  }
}
