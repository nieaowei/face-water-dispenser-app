import 'package:flutter/cupertino.dart';
import 'package:qrscan/qrscan.dart';

class LayoutPage extends StatelessWidget {
  final String title;
  final List<Widget> slivers;
  LayoutPage({Key key, this.title, this.slivers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    list.add(CupertinoSliverNavigationBar(
      largeTitle: Text(this.title),
      trailing: CupertinoButton(child:Icon(CupertinoIcons.barcode_viewfinder),onPressed:(){

      })
    ));
    list.addAll(this.slivers);
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: CupertinoScrollbar(
            child: CustomScrollView(
          slivers: list,
        )));
  }
}
