import 'package:dio/dio.dart';
import 'package:face_water_dispenser/repository/http.dart';

import 'notify_msg_entity.dart';



class NotifyApi {
  static Future<Resp<List<NotifyMsgEntity>>> getList() async {
    await HttpUtil.getInstance()
        .get(
          "/",
        )
        .then((value) => Resp<List<NotifyMsgEntity>>.fromJson(value.data));
  }
}
