import 'package:face_water_dispenser/main_logic.dart';
import 'package:face_water_dispenser/page/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class ControlPage extends StatelessWidget {
  final ControlLogic logic = Get.put(ControlLogic());
  final ControlState state = Get.find<ControlLogic>().state;
  final _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      key:_key,
      title: "控制",
      slivers: [

      ],
    );
  }
}
