import 'package:dio/dio.dart';

class UserService {
  final dio = Dio();
  final String url = "http://10.0.2.2:3000/api/";
  registerUser(String userdata) async {
    final response = await dio.post("${url}register", data: userdata);
    return response;
  }

  loginUser(String userdata) async {
    final response = await dio.post("${url}login", data: userdata);
    return response;
  }

  getAllPendingHospitals() async {
    final response = await dio.get("${url}pending-hospitals");
    return response;
  }

  getAllPendingWorkshops() async {
    final response = await dio.get("${url}pending-workshops");
    return response;
  }

  approveHospital(String hospitalData) async {
    final response =
        await dio.post("${url}approve-hospital", data: hospitalData);
    return response;
  }

  approveWorkshop(String workshopData) async {
    final response =
        await dio.post("${url}approve-workshop", data: workshopData);
    return response;
  }
}
