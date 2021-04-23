import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:face_water_dispenser/page/noLogin.dart';
import 'package:face_water_dispenser/repository/monitor_msg_entity.dart';
import 'package:face_water_dispenser/repository/mqtt.dart';
import 'package:face_water_dispenser/repository/notify_msg_entity.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'generated/json/base/json_convert_content.dart';
import 'main_state.dart';

class MainLogic extends GetxController {
  final state = MainState();
  MqttServerClient client;

  @override
  void onInit() {
    checkLogged();
    setLogOut();
    mqtt();
    super.onInit();
  }

  void checkLogged() async {
    state.logined.value = await checkLogin();
  }

  void setLogged() async {
    print("setLogged");
    await setLoginInfo(true, "token");
    state.logined.value = true;
    if (client == null) {
      mqtt();
    }
  }

  void setLogOut() async {
    await setLoginInfo(false, "token");
    state.logined.value = false;
  }

  void setOnline() {
    print("setOnline");
    state.onlined.value = true;
  }

  void getLock() {
    state.locked.value = true;
  }

  void setLock(bool ok){
    state.locked.value = ok;
  }

  void mqtt() {
    Timer tim;
    Timer tim2;
    // tim.cancel()
    if (state.logined.value) {
      log(DateTime.now().toString() + "mqtt init");
      MqttUtil.connect(
        onConnected: () {},
      ).then((value) {
        value.pongCallback = () {
          // log(DateTime.now().toString() + "ping");
          // tim?.cancel();
          // state.onlined.value = true;
          // tim = Timer(Duration(seconds: 60), () {
          //   state.onlined.value = false;
          // });
        };
        value.subscribe("/nekilc/device/ping", MqttQos.atLeastOnce);
        value.subscribe("/nekilc/device/monitor", MqttQos.atLeastOnce);
        value.subscribe("/nekilc/notify", MqttQos.atLeastOnce);

        value.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          final MqttPublishMessage message = c[0].payload;
          final payload =
              MqttPublishPayload.bytesToStringAsString(message.payload.message);
          print('Received message:$payload from topic: ${c[0].topic}>');
          if (c[0].topic == "/nekilc/device/ping") {
            var map = jsonDecode(payload);
            log(DateTime.now().toString() + payload);
            tim2?.cancel();
            state.onlined.value = true;
            tim2 = Timer(Duration(seconds: 10), () {
              state.onlined.value = false;
            });
            // state.monitorMsg.value = JsonConvert.fromJsonAsT<MonitorMsgEntity>(map);
          }
          if (c[0].topic == "/nekilc/device/monitor") {
            var map = jsonDecode(payload);
            log(DateTime.now().toString() + payload);
            state.monitorMsg.value =
                JsonConvert.fromJsonAsT<MonitorMsgEntity>(map);
          }
          if (c[0].topic == "/nekilc/notify") {
            var map = jsonDecode(payload);
            log(DateTime.now().toString() + payload);
            // state.notifyMsgList.value
            //     .addAll(JsonConvert.fromJsonAsT<List<NotifyMsgEntity>>(map));
            List<NotifyMsgEntity> t = state.notifyMsgList.value;
            t.addAll(JsonConvert.fromJsonAsT<List<NotifyMsgEntity>>(map));
            state.notifyMsgList.value = t;
            // state.notifyMsgList.value = state.notifyMsgList.value;
          }
        });
      });
    }
  }
}
