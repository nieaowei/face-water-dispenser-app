import 'dart:convert';

import 'package:face_water_dispenser/generated/json/base/json_convert_content.dart';
import 'package:face_water_dispenser/repository/http.dart';
import 'package:face_water_dispenser/repository/monitor.dart';
import 'package:face_water_dispenser/repository/monitor_msg_entity.dart';
import 'package:face_water_dispenser/repository/monitor_used_water_time_msg_entity.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'state.dart';

class MonitorLogic extends GetxController {
  final state = MonitorState();
  MqttClient client;

  @override
  void onInit() {
    print("MonitorLogic Init");
    // getMonitorMsg();
    // MqttClient = connect().then((value) {
    //   client = value;
    // });
  }

  getMonitorMsg() async {
    await MonitorApi.getMonitorMsg();
  }
}
