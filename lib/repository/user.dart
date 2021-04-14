
import 'package:dio/dio.dart';
import 'package:face_water_dispenser/repository/http.dart';

class UserApi {
  static Future<Response<String>> login({String username, String password}) {
    return HttpUtil.getInstance().get<String>(
      "/",
    );
  }
}
