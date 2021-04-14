import 'package:face_water_dispenser/page/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class NotifyPage extends StatelessWidget {
  final NotifyLogic logic = Get.put(NotifyLogic());
  final NotifyState state = Get.find<NotifyLogic>().state;
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
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
    return SizeTransition(
        sizeFactor: animation,
        child: _msgItem(context, state.list[state.list.length - index - 1].date,
            state.list[state.list.length - index - 1].content));
  }

  @override
  Widget build(BuildContext context) {
    theme = CupertinoTheme.of(context);
    return LayoutPage(
      title: "通知",
      slivers: [
        SliverAnimatedList(
            key: _listKey,
            itemBuilder: _itemBuilder,
            initialItemCount: state.list.value.length),
        SliverToBoxAdapter(
            child: CupertinoButton.filled(
                child: Text("刷新"),
                onPressed: () {
                  logic.fetchLatest();
                  _listKey.currentState.insertItem(0);
                }))
      ],
    );
  }
}
