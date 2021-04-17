import 'package:dio/dio.dart';
import 'package:face_water_dispenser/page/control/view.dart';
import 'package:face_water_dispenser/page/error.dart';
import 'package:face_water_dispenser/page/monitor/view.dart';
import 'package:face_water_dispenser/page/noLogin.dart';
import 'package:face_water_dispenser/page/notify/view.dart';
import 'package:face_water_dispenser/page/profile/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'main_logic.dart';
import 'main_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MainLogic logic = Get.put(MainLogic());
    final MainState state = Get
        .find<MainLogic>()
        .state;
    return GetCupertinoApp(
      title: '人脸识别饮水机',
      // initialRoute: "/",
      getPages: [GetPage(name: "/login", page: () => ProfilePage())],
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Color(2),
          items: [
            BottomNavigationBarItem(
                label: '监控', icon: Icon(CupertinoIcons.device_laptop)),
            BottomNavigationBarItem(
                label: '控制', icon: Icon(CupertinoIcons.power)),
            BottomNavigationBarItem(
                label: '通知', icon: Icon(CupertinoIcons.bubble_left)),
            BottomNavigationBarItem(
                label: '个人信息', icon: Icon(CupertinoIcons.person))
          ],
        ),
        tabBuilder: (context, index) {
          return SafeArea(
              top: false,
              child: CupertinoTabView(builder: (context) {
                switch (index) {
                  case 0:
                    return MonitorPage();
                  case 1:
                    return ControlPage();
                  case 2:
                    return NotifyPage();
                  case 3:
                    return ProfilePage();
                }
                return Container(child: Text('404'));
              }));
        },
      ),
    );
  }
}
