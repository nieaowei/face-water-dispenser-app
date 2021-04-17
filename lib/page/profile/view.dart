import 'package:face_water_dispenser/component/login/view.dart';
import 'package:face_water_dispenser/main_logic.dart';
import 'package:face_water_dispenser/main_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../layout.dart';
import 'logic.dart';
import 'state.dart';

class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CupertinoFormSection.insetGrouped(
      children: [
        CupertinoButton(
            color: CupertinoColors.white,
            disabledColor: CupertinoColors.white,
            child: Row(
              children: [
                Icon(CupertinoIcons.person, color: CupertinoColors.black),
                Expanded(
                  child: Text("我的",
                      style: TextStyle(color: CupertinoColors.black)),
                )
              ],
            ),
            onPressed: () {}),
        CupertinoFormRow(
            child: CupertinoButton(child: Text("我的"), onPressed: () {}),
            prefix: Icon(CupertinoIcons.person)),
        CupertinoFormRow(
            child: CupertinoButton(child: Text("我的"), onPressed: () {}),
            prefix: Icon(CupertinoIcons.person)),
        CupertinoFormRow(
            child: CupertinoButton(child: Text("我的"), onPressed: () {}),
            prefix: Icon(CupertinoIcons.person)),
      ],
    ));
  }
}

class ProfilePage extends StatelessWidget {
  final ProfileLogic logic = Get.put(ProfileLogic());
  final ProfileState state = Get.find<ProfileLogic>().state;
  final MainState _mainState = Get.find<MainLogic>().state;
  CupertinoThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = CupertinoTheme.of(context);
    return LayoutPage(
      trailings: [
        Container(
            child: Obx(
          () => Icon(CupertinoIcons.circle_fill,
              size: theme.textTheme.textStyle.fontSize,
              color: _mainState.onlined.value
                  ? CupertinoColors.systemGreen
                  : CupertinoColors.systemRed),
        )),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            print( _mainState.onlined.value);
            print( _mainState.logined.value);
          },
          child: Icon(CupertinoIcons.qrcode_viewfinder),
        ),
      ],
      title: "我的",
      slivers: [
        SliverToBoxAdapter(
            child: Obx(
                () => _mainState.logined.value ? ProfileMenu() : LoginCom()))
      ],
    );
  }
}
