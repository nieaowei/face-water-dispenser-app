import 'package:face_water_dispenser/repository/notify.dart';
import 'package:get/get.dart';

import 'state.dart';

class NotifyLogic extends GetxController {
  final state = NotifyState();

  @override
  void onInit() {
    state.list.value = <NotifyMsg>[NotifyMsg(date:"2021-04-14 15:45:00",content: "31231")];
  }

  Future<List<NotifyMsg>> getList() async{
    await NotifyApi.getList();
  }

  fetchLatest(){
    state.list.value.add(NotifyMsg(date:"123",content: "qwe"));
  }
}
