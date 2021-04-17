import 'package:face_water_dispenser/main_logic.dart';
import 'package:face_water_dispenser/page/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_state.dart';
import '../noLogin.dart';
import 'logic.dart';
import 'state.dart';

class ControlPage extends StatelessWidget {
  final ControlLogic logic = Get.put(ControlLogic());
  final ControlState state = Get.find<ControlLogic>().state;
  final MainState _mainState = Get.find<MainLogic>().state;
  CupertinoThemeData theme;
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    theme = CupertinoTheme.of(context);
    return LayoutPage(
      key: _key,
      title: "控制",
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
            print(_mainState.onlined.value);
            print(_mainState.logined.value);
          },
          child: Icon(CupertinoIcons.qrcode_viewfinder),
        ),
      ],
      slivers: _mainState.logined.value
          ? [
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    color: Colors.primaries[index % Colors.primaries.length],
                  );
                }, childCount: 4),
              ),
              SliverToBoxAdapter()
            ]
          : [
              // SliverFillRemaining(child: SafeArea(child:Center(child:Text("dsa"))),),
              SliverSafeArea(
                  sliver:SliverFillRemaining(child:Center(child:Text("dsa")))
              ),
            ],
    );
  }
}
