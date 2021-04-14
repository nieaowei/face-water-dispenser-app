import 'package:face_water_dispenser/page/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class MonitorPage extends StatelessWidget {
  final MonitorLogic logic = Get.put(MonitorLogic());
  final MonitorState state = Get.find<MonitorLogic>().state;
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      key:_key,
      title:"监控",
      slivers: [
      ],
    );
  }
}
