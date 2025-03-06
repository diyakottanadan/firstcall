import 'package:dio/dio.dart';

class AlertServices {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";
  registerUser(String userdata) async {
    final response = await dio.post("${url}register", data: userdata);
    return response;
  }

  Future<Response> addAlert(String alertData) async {
    final response = await dio.post("${url}addAlert", data: alertData);
    return response;
  }

  Future<Response> getAlertByHospitalId(String hospitalId) async {
    final response =
        await dio.post("${url}getAlertByHospitalId", data: hospitalId);
    return response;
  }

  Future<Response> getAlertByDistrict(String district) async {
    final response = await dio.post("${url}getAlertByDistrict", data: district);
    return response;
  }

  Future<Response> changeAlertStatus(String alertId) async {
    final response = await dio.post("${url}changeAlertStatus", data: alertId);
    return response;
  }
}
