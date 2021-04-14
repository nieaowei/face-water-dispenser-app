import 'package:face_water_dispenser/repository/notify.dart';
import 'package:get/get.dart';



class NotifyState {
  NotifyState() {
    ///Initialize variables
    list = <NotifyMsg>[].obs;
  }

  RxList list;
}
