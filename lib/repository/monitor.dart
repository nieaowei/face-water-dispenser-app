import 'package:dio/dio.dart';

import 'http.dart';
import 'monitor_msg_entity.dart';

class MonitorApi {
  static Future<Resp<MonitorMsgEntity>> getMonitorMsg() async {
    Resp<MonitorMsgEntity> res= await HttpUtil.getInstance().get(
      "/user/monitor/data",
    ).then((value) => Resp<MonitorMsgEntity>.fromJson(value.data));
    // return Resp<MonitorMsgEntity>.fromJson(resp.data);
    return res;
  }
}
