import 'package:get/get.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final state = LoginState();

  setValid(bool valid){
    state.valid.value = valid;
  }
}
