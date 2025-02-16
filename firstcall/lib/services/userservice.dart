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
}
