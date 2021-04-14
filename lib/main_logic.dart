import 'package:face_water_dispenser/page/noLogin.dart';
import 'package:get/get.dart';

import 'main_state.dart';

class MainLogic extends GetxController {
  final state = MainState();
  var logined = false.obs;
  @override
  void onInit() {
     checkLogged();
     setLogOut();
     super.onInit();
  }

  void checkLogged() async{
    state.logined.value = await checkLogin();
  }

  void setLogged() async{
    await setLoginInfo(true, "token");
    state.logined.value = true;
  }

  void setLogOut() async{
    await setLoginInfo(false, "token");
    state.logined.value = false;
  }
}
