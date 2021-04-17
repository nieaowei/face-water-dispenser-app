import 'package:face_water_dispenser/component/login/view.dart';
import 'package:face_water_dispenser/page/profile/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("logined") ?? false;
}

Future<bool> setLoginInfo(bool logined, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool ok = await prefs.setBool("logined", logined);
  if (!ok) {
    return false;
  }
  ok = await prefs.setString("token", token);
  if (!ok) {
    return false;
  }
  return true;
}

// class NoLoginPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _NoLoginPageState();
//   }
// }

class NoLoginPage extends StatelessWidget {
  CupertinoThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = CupertinoTheme.of(context);

    return Container(
        child: Column(
      children: [
        Text("未登录", style: theme.textTheme.navLargeTitleTextStyle),
        // Expanded(
        //   child:
        // ),
        CupertinoButton.filled(
            child: Text("前往登录"),
            onPressed: () {
              Get.toNamed("/login");
            }),
      ],
    ));
  }
}
