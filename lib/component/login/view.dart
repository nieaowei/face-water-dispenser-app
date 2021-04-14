import 'package:face_water_dispenser/page/noLogin.dart';
import 'package:face_water_dispenser/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_logic.dart';
import '../../main_state.dart';
import 'logic.dart';
import 'state.dart';

class LoginCom extends StatelessWidget {
  final LoginLogic logic = Get.put(LoginLogic());
  final LoginState state = Get.find<LoginLogic>().state;
  final MainState _mainState = Get.find<MainLogic>().state;
  final MainLogic _mainLogic = Get.put(MainLogic());

  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Function pressed = () {
      if (true) {
        return () {
          print("login");
          UserApi.login().then((value)  {
            print(value);
            _mainLogic.setLogged();
          }).onError((error, stackTrace) {
            print("onError");
            print(error);
          }).catchError((error){
            print("catchError");
            print(error);
          }).whenComplete((){
            print("whenComplete");
          });
        };
      } else {
        return null;
      }
    };
    Function textColor = () {
      if (true) {
        return CupertinoColors.activeBlue;
      }else{
        return CupertinoColors.systemGrey;
      }
    };
    return Container(
      child: Column(
        children: [
          CupertinoFormSection(
            key: _loginFormKey,
            margin: EdgeInsets.only(top: 30),
            // key: _loginFormKey,
            children: [
              CupertinoTextFormFieldRow(
                prefix: Text("账号"),
                placeholder: "账号",
                // onChanged: (value) {
                //   logic.setValid(true);
                // },
                style: TextStyle(height: 1),
                validator: (value) {
                  return null;
                },
              ),
              CupertinoTextFormFieldRow(
                prefix: Text("密码"),
                textAlignVertical: TextAlignVertical.center,
                placeholder: "密码",
                obscureText: true,
                style:TextStyle(
                  height:1,
                ),
                validator: (value) {
                  return null;
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: CupertinoButton(
                  alignment: Alignment.centerLeft,
                  color: CupertinoColors.systemBackground,
                  disabledColor: CupertinoColors.white,
                  padding: EdgeInsets.only(left: 10),
                  borderRadius: BorderRadius.zero,
                  child: Text("登录", style: TextStyle(color: CupertinoColors.activeBlue)),
                  onPressed: pressed()),
            ),
          ),
        ],
      ),
    );
  }
}
