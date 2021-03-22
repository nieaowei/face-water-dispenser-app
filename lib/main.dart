import 'package:face_water_dispenser/page/Control.dart';
import 'package:face_water_dispenser/page/monitor.dart';
import 'package:face_water_dispenser/page/notify.dart';
import 'package:face_water_dispenser/page/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: '人脸识别饮水机',
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
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
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return MonitorPage('监控');
                },
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return Control();
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return NotifyPage();
                },
              );
            case 3:
              return CupertinoTabView(
                  builder: (context) {
                    return ProfilePage();
                  },
                );
          }
          return Container(
            child:Text('404')
          );
        },
      ),
    );
  }
}
