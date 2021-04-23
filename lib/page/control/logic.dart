import 'dart:async';

import 'package:get/get.dart';

import 'state.dart';

class ControlLogic extends GetxController {
  final state = ControlState();

  setOpen() {
    state.open.value = true;
    Timer(Duration(seconds: 1), () {
      state.open.value = false;
    });
  }
}
