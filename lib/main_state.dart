import 'package:face_water_dispenser/repository/monitor_msg_entity.dart';
import 'package:face_water_dispenser/repository/notify_msg_entity.dart';
import 'package:get/get.dart';

class MainState {
  MainState() {
    ///Initialize variables
    logined = false.obs;
    onlined = false.obs;
    locked = false.obs;
    monitorMsg = MonitorMsgEntity().obs;
    notifyMsgList = <NotifyMsgEntity>[].obs;
  }

  RxList notifyMsgList;
  RxBool logined;
  RxBool onlined;

  RxBool locked;
  RxObjectMixin<MonitorMsgEntity> monitorMsg;
}
