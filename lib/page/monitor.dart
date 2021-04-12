
import 'package:flutter/cupertino.dart';

class MonitorPage extends StatefulWidget {
  
  final String title;

  const MonitorPage(String s, {Key key, this.title}) : super(key: key);

  @override
  _MonitorPageState createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('监控'),
          ),
        ],
      )
    );
  }
}