import 'package:face_water_dispenser/repository/monitor_msg_entity.dart';
import 'package:face_water_dispenser/repository/monitor_used_water_time_msg_entity.dart';
import 'package:get/get.dart';

class MonitorState {
  MonitorState() {
    ///Initialize variables
    monitorMsg = MonitorMsgEntity().obs;
    monitorUsedWaterTimeMsg = <MonitorUsedWaterTimeMsgEntity>[].obs;
  }
  final String MonitorMsgTopic = "/nekilc/monitor/common";
  final String MonitorUsedWaterTimeMsgTopic = "/nekilc/monitor/usedWater";

  RxObjectMixin<MonitorMsgEntity> monitorMsg;
  RxList<MonitorUsedWaterTimeMsgEntity> monitorUsedWaterTimeMsg;
}
