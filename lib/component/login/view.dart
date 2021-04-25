import 'package:face_water_dispenser/page/noLogin.dart';
import 'package:face_water_dispenser/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../main_logic.dart';
import '../../main_state.dart';
import 'logic.dart';
import 'state.dart';

class LoginCom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginCom1();
  }
}

class _LoginCom1 extends State<LoginCom> {
  final LoginLogic logic = Get.put(LoginLogic());
  final LoginState state = Get.find<LoginLogic>().state;
  final MainState _mainState = Get.find<MainLogic>().state;
  final MainLogic _mainLogic = Get.put(MainLogic());
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  CupertinoThemeData theme;
  String _username = "";

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    theme = CupertinoTheme.of(context);
    Function pressed = () {
      print("login");
      _loginFormKey.currentState.save();
      print(_username);
      // _mainLogic.setLogged();
      // _mainLogic.setOnline();
      // UserApi.login().then((value) {
      //   print(value);
      //   _mainLogic.setLogged();
      // }).onError((error, stackTrace) {
      //   print("onError");
      //   print(error);
      // }).catchError((error) {
      //   print("catchError");
      //   print(error);
      // }).whenComplete(() {
      //   print("whenComplete");
      // });
    };
    Function textColor = () {
      if (true) {
        return CupertinoColors.activeBlue;
      } else {
        return CupertinoColors.systemGrey;
      }
    };
    return Container(
      child: Column(
        children: [
          Form(
            key: _loginFormKey,
            child: CupertinoFormSection(
              margin: EdgeInsets.only(top: 30),
              children: [
                CupertinoTextFormFieldRow(
                  prefix: Text("账号"),
                  placeholder: "账号",
                  // onChanged: (value) {
                  //   logic.setValid(true);
                  // },
                  onSaved: (v) => _username = v,
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
                  style: TextStyle(
                    height: 1,
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: CupertinoButton(
                  alignment: Alignment.centerLeft,
                  color: theme.barBackgroundColor,
                  disabledColor: CupertinoColors.white,
                  padding: EdgeInsets.only(left: 10),
                  borderRadius: BorderRadius.zero,
                  child: Text("登录",
                      style: TextStyle(color: CupertinoColors.activeBlue)),
                  onPressed: pressed),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginCom1 extends StatelessWidget {
  final LoginLogic logic = Get.put(LoginLogic());
  final LoginState state = Get.find<LoginLogic>().state;
  final MainState _mainState = Get.find<MainLogic>().state;
  final MainLogic _mainLogic = Get.put(MainLogic());

  @override
  Widget build(BuildContext context) {
    var _username = "";
    var _password = "";

    Function pressed = () {
      if (true) {
        return () {
          print("login");
          // _loginFormKey.currentState.save();
          print(_username);
          // _mainLogic.setLogged();
          // _loginFormKey.currentState.save();
          // _mainLogic.setOnline();
        };
      } else {
        return null;
      }
    };
    Function textColor = () {
      if (true) {
        return CupertinoColors.activeBlue;
      } else {
        return CupertinoColors.systemGrey;
      }
    };
    return Container(
      child: Column(
        children: [
          StatefulBuilder(builder: (BuildContext context, StateSetter set) {
            final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
            return Form(
                child: CupertinoFormSection(
              key: _loginFormKey,
              margin: EdgeInsets.only(top: 30),
              children: [
                CupertinoTextFormFieldRow(
                  prefix: Text("账号"),
                  placeholder: "账号",
                  // onChanged: (value) {
                  //   logic.setValid(true);
                  // },
                  onSaved: (v) => _username = v,
                  style: TextStyle(height: 1),
                  // validator: (value) {
                  //   return null;
                  // },
                ),
                CupertinoTextFormFieldRow(
                  prefix: Text("密码"),
                  textAlignVertical: TextAlignVertical.center,
                  placeholder: "密码",
                  obscureText: true,
                  onSaved: (v) => _password = v,
                  style: TextStyle(
                    height: 1,
                  ),
                  // validator: (value) {
                  //   return null;
                  // },
                ),
              ],
            ));
            return CupertinoFormSection(
              key: _loginFormKey,
              margin: EdgeInsets.only(top: 30),
              children: [
                CupertinoTextFormFieldRow(
                  prefix: Text("账号"),
                  placeholder: "账号",
                  // onChanged: (value) {
                  //   logic.setValid(true);
                  // },
                  onSaved: (v) => _username = v,
                  style: TextStyle(height: 1),
                  // validator: (value) {
                  //   return null;
                  // },
                ),
                CupertinoTextFormFieldRow(
                  prefix: Text("密码"),
                  textAlignVertical: TextAlignVertical.center,
                  placeholder: "密码",
                  obscureText: true,
                  onSaved: (v) => _password = v,
                  style: TextStyle(
                    height: 1,
                  ),
                  // validator: (value) {
                  //   return null;
                  // },
                ),
              ],
            );
          }),
          // CupertinoFormSection(
          //   // key: _loginFormKey,
          //   margin: EdgeInsets.only(top: 30),
          //   children: [
          //     CupertinoTextFormFieldRow(
          //       prefix: Text("账号"),
          //       placeholder: "账号",
          //       // onChanged: (value) {
          //       //   logic.setValid(true);
          //       // },
          //       onSaved: (v)=>_username=v,
          //       style: TextStyle(height: 1),
          //       // validator: (value) {
          //       //   return null;
          //       // },
          //     ),
          //     CupertinoTextFormFieldRow(
          //       prefix: Text("密码"),
          //       textAlignVertical: TextAlignVertical.center,
          //       placeholder: "密码",
          //       obscureText: true,
          //       onSaved: (v)=>_password=v,
          //       style: TextStyle(
          //         height: 1,
          //       ),
          //       // validator: (value) {
          //       //   return null;
          //       // },
          //     ),
          //   ],
          // ),
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
                  child: Text("登录",
                      style: TextStyle(color: CupertinoColors.activeBlue)),
                  onPressed: pressed()),
            ),
          ),
        ],
      ),
    );
  }
}
