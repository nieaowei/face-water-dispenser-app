import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';

class LayoutPage extends StatelessWidget {
  final String title;
  final List<Widget> slivers;
  final Future<void> Function() onRefresh;
  final bool stretch;
  CupertinoThemeData theme;

  List<Widget> trailings;

  LayoutPage({
    Key key,
    this.title,
    this.slivers,
    this.onRefresh,
    this.trailings,
    this.stretch = false,
  }) : super(key: key);

  List<Widget> _buildList(BuildContext context) {
    List<Widget> list = [];
    list.add(CupertinoSliverNavigationBar(
        automaticallyImplyTitle: false,
        stretch: stretch,

        // middle: Text(this.title),
        largeTitle: Text(this.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: trailings ?? [],
        )));
    if (onRefresh != null) {
      list.add(CupertinoSliverRefreshControl(onRefresh: onRefresh));
    }
    if (slivers == null || slivers.length == 0) {
      list.add(SliverFillRemaining(
          hasScrollBody: false, child: Center(child: Text("123"))));
    } else {
      list.addAll(this.slivers);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    theme = CupertinoTheme.of(context);
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: CupertinoScrollbar(
            child: CustomScrollView(
          primary: true,
          slivers: _buildList(context),
        )));
  }
}
