import 'package:dio/dio.dart';

class WorkshopService {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";
  registerUser(String userdata) async {
    final response = await dio.post("${url}register", data: userdata);
    return response;
  }

  viewWorkshopUserByDistrict(String districtData) async {
    final response = await dio.post("${url}viewWorkshopUserByDistrict",
        data: {"district": districtData});
    return response;
  }

  addWorkshopRequest(String requestData) async {
    final response =
        await dio.post("${url}addWorkshopRequest", data: requestData);
    return response;
  }

  getWorkshopRequestByUserId(String userId) async {
    final response =
        await dio.post("${url}getWorkshopRequestByUserId", data: userId);
    return response;
  }

  getRequestByWorkshopId(String workshopId) async {
    final response =
        await dio.post("${url}getRequestByWorkshipId", data: workshopId);
    return response;
  }

  replyToWorkshopRequest(String replyData) async {
    final response =
        await dio.post("${url}replyToWorkshopRequest", data: replyData);
    return response;
  }
}
