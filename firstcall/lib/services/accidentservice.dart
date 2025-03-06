import 'package:dio/dio.dart';

class AccidentService {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";
  registerUser(String userdata) async {
    final response = await dio.post("${url}register", data: userdata);
    return response;
  }

  Future<Response> addAccidentReport(String accidentData) async {
    final response = await dio.post("${url}add-accident", data: accidentData);
    return response;
  }

  Future<Response> getAccidentReportByUserId(String userId) async {
    final response =
        await dio.get("${url}get-accident-by-userid", data: userId);
    return response;
  }

  Future<Response> getAccidentReportByPoliceId(String policeId) async {
    final response =
        await dio.get("${url}get-accident-by-policeid", data: policeId);
    return response;
  }

  Future<Response> replyToAccidentReport(String replyData) async {
    final response =
        await dio.post("${url}add-reply-accident", data: replyData);
    return response;
  }

  Future<Response> getPoliceByDistrict(String district) async {
    final response =
        await dio.get("${url}get-police-by-district", data: district);
    return response;
  }
}
