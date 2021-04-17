import 'package:face_water_dispenser/repository/notify.dart';
import 'package:face_water_dispenser/repository/notify_msg_entity.dart';
import 'package:get/get.dart';



class NotifyState {
  NotifyState() {
    ///Initialize variables
    list = <NotifyMsgEntity>[].obs;
  }

  RxList list;
}
