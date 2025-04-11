import 'package:dio/dio.dart';

class CertificateService {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";
  registerUser(String userdata) async {
    final response = await dio.post("${url}register", data: userdata);
    return response;
  }

  addCertificate(String certificateData) async {
    final response =
        await dio.post("${url}addCertificate", data: certificateData);
    return response;
  }

  getCertificateByPoliceId(String policeId) async {
    final response =
        await dio.post("${url}getCertificateByPoliceId", data: policeId);
    return response;
  }

  getCertificateByUserId(String userId) async {
    final response =
        await dio.post("${url}getCertificateByUserId", data: userId);
    return response;
  }

  getCertificateById(String certificateId) async {
    final response =
        await dio.post("${url}getCertificateById", data: {"id": certificateId});
    return response;
  }

  updateCertificateStatus(String statusData) async {
    final response =
        await dio.post("${url}updateCertificateStatus", data: statusData);
    return response;
  }
}
