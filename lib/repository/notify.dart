import 'package:dio/dio.dart';
import 'package:face_water_dispenser/repository/http.dart';

class NotifyMsg {
  String date;
  String content;

  NotifyMsg({this.date, this.content});
}

class NotifyApi {
  static Future<Response<Resp<List<NotifyMsg>>>> getList() {
    return HttpUtil.getInstance().get<Resp<List<NotifyMsg>>>(
      "/",
    );
  }
}
