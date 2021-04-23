import 'dart:async';

import 'package:face_water_dispenser/main_logic.dart';
import 'package:face_water_dispenser/page/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main_state.dart';
import '../noLogin.dart';
import 'logic.dart';
import 'state.dart';

class SwitchItem {
  Widget title;
  Widget icon;
  IconData closeIcon;
  void Function() onPressed;

  SwitchItem(Widget title, Widget icon, Function onPressed) {
    this.title = title;
    this.icon = icon;
    this.closeIcon = closeIcon;
    this.onPressed = onPressed;
  }
}

class ControlPage extends StatelessWidget {
  final ControlLogic logic = Get.put(ControlLogic());
  final ControlState state = Get.find<ControlLogic>().state;
  final MainState _mainState = Get.find<MainLogic>().state;
  final MainLogic _mainLogic = Get.put(MainLogic());
  CupertinoThemeData theme;
  final _key = GlobalKey();

  Widget _buildSwitchItem<T>(BuildContext context, int index) {
    // RxObjectMixin<Color> color = CupertinoColors.systemGreen.obs;
    RxBool pressed = false.obs;
    List<SwitchItem> switchItems = <SwitchItem>[
      SwitchItem(
          Obx(() => Text(
                state.open.value ? "正在出水" : "出水就绪",
                style:
                    TextStyle(color: theme.textTheme.tabLabelTextStyle.color),
              )),
          Obx(() => Icon(
                state.open.value
                    ? CupertinoIcons.drop_fill
                    : CupertinoIcons.drop,
                color: state.open.value
                    ? CupertinoColors.systemRed
                    : CupertinoColors.systemGreen,
                size: 80,
              )),
          () => {logic.setOpen()}),
      SwitchItem(
          Obx(() => Text(
                _mainState.locked.value ? "已锁定" : "未锁定",
                style:
                    TextStyle(color: theme.textTheme.tabLabelTextStyle.color),
              )),
          Obx(() => Icon(
                _mainState.locked.value
                    ? CupertinoIcons.lock
                    : CupertinoIcons.lock_open,
                color: _mainState.locked.value
                    ? CupertinoColors.systemRed
                    : CupertinoColors.systemGreen,
                size: 80,
              )),
          () => {_mainLogic.setLock(!_mainState.locked.value)}),
    ];
    return CupertinoPopupSurface(
        child: Container(
      padding: EdgeInsets.all(10),
      color: theme.barBackgroundColor,
      child: Column(
        children: [
          GestureDetector(
            child: Obx(() => Container(
                  padding: EdgeInsets.all(20),
                  decoration: ShapeDecoration(
                      color: pressed.value
                          ? theme.barBackgroundColor
                          : theme.primaryContrastingColor,
                      shape: CircleBorder()),
                  child: switchItems[index].icon,
                )),
            onTap: () {
              switchItems[index].onPressed();
            },
            onTapDown: (TapDownDetails t) {
              pressed.value = true;
            },
            onTapUp: (TapUpDetails t) {
              Timer(Duration(milliseconds: 100), () {
                pressed.value = false;
              });
            },
          ),
          Spacer(),
          switchItems[index].title,
        ],
      ),
    ));
  }

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
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return _buildSwitchItem(context, index);
                  }, childCount: 2),
                ),
              ),
              // SliverPadding(
              //     padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              //     sliver: SliverToBoxAdapter(
              //       child: CupertinoPopupSurface(
              //           child: Container(
              //         color: CupertinoColors.white,
              //         padding: EdgeInsets.only(left: 10),
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: Padding(
              //                   padding: EdgeInsets.only(right: 10),
              //                   child: CupertinoTextField(
              //                     decoration: BoxDecoration(
              //                       border: Border(bottom: BorderSide()),
              //                     ),
              //                     textAlign: TextAlign.end,
              //                     suffix: Padding(
              //                         padding: EdgeInsets.only(right: 5),
              //                         child: Text("ml")),
              //                   )),
              //             ),
              //             CupertinoButton.filled(
              //                 padding: EdgeInsets.only(
              //                     top: 10, bottom: 10, left: 20, right: 20),
              //                 child: Text("设置流量"),
              //                 onPressed: () {})
              //           ],
              //         ),
              //       )),
              //     ))
            ]
          : [
              // SliverFillRemaining(child: SafeArea(child:Center(child:Text("dsa"))),),
              SliverSafeArea(
                  sliver:
                      SliverFillRemaining(child: Center(child: Text("dsa")))),
            ],
    );
  }
}
