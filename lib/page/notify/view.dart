import 'package:face_water_dispenser/component/login/view.dart';
import 'package:face_water_dispenser/page/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../main_logic.dart';
import '../../main_state.dart';
import '../noLogin.dart';
import 'logic.dart';
import 'state.dart';

class NotifyPage extends StatelessWidget {
  final NotifyLogic logic = Get.put(NotifyLogic());
  final NotifyState state = Get.find<NotifyLogic>().state;
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  final MainState _mainState = Get.find<MainLogic>().state;

  var theme;

  Widget _msgItem(BuildContext context, String date, String content) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: CupertinoColors.systemGrey4, width: 0.2))),
        padding: EdgeInsets.all(10),
        child: FractionallySizedBox(
            widthFactor: 1,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(date,
                  style: TextStyle(
                      color: theme.textTheme.textStyle.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              Text(content,
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  )),
            ])));
  }

  Widget _itemBuilder(
      BuildContext context, int index, Animation<double> animation) {
    // state.list.addAll(_mainState.notifyMsgList.value);
    return SizeTransition(
        sizeFactor: animation,
        child: Obx(() => _msgItem(
            context,
            _mainState.notifyMsgList
                .value[_mainState.notifyMsgList.value.length - index - 1].date,
            _mainState
                .notifyMsgList
                .value[_mainState.notifyMsgList.value.length - index - 1]
                .content)));
  }

  @override
  Widget build(BuildContext context) {
    theme = CupertinoTheme.of(context);
    return LayoutPage(
      title: "通知",
      onRefresh: () async =>
          {logic.fetchLatest(), _listKey.currentState.insertItem(0)},
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
              SliverAnimatedList(
                  key: _listKey,
                  itemBuilder: _itemBuilder,
                  initialItemCount: _mainState.notifyMsgList.value.length),
            ]
          : [
              SliverToBoxAdapter(child: LoginCom1()),
            ],
    );
  }
}
