import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginState {
  LoginState() {
    ///Initialize variables
    valid = false.obs;

  }
  RxBool valid;
}
