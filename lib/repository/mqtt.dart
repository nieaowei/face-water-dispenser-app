import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttUtil {
  static MqttServerClient client;

  static Future<MqttClient> connect({void Function() ping,void Function() onConnected}) async {
    client = MqttServerClient.withPort('broker.emqx.io', 'nieaowei14123', 1883);
    client.logging(on: false);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = ping;
    client.doAutoReconnect(force: true);

    final connMess = MqttConnectMessage()
        .withClientIdentifier("nieaowei14123")
        .authenticateAs("test", "test")
        .keepAliveFor(60)
        .withWillTopic('nekilc')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;
    try {
      print('Connecting');
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
    //
    // if (client.connectionStatus.state == MqttConnectionState.connected) {
    //   client.subscribe(state.MonitorMsgTopic, MqttQos.atLeastOnce);
    //   client.subscribe(state.MonitorUsedWaterTimeMsgTopic, MqttQos.atLeastOnce);
    //
    //   print('EMQX client connected');
    //   client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    //     final MqttPublishMessage message = c[0].payload;
    //     final payload =
    //     MqttPublishPayload.bytesToStringAsString(message.payload.message);
    //     // print('Received message:$payload from topic: ${c[0].topic}>');
    //     if(c[0].topic=="/nekilc/monitor/common"){
    //       var map = jsonDecode(payload);
    //       state.monitorMsg.value = JsonConvert.fromJsonAsT<MonitorMsgEntity>(map);
    //     }
    //   });
    //
    //   client.published.listen((MqttPublishMessage message) {
    //     print('published');
    //     final payload =
    //     MqttPublishPayload.bytesToStringAsString(message.payload.message);
    //     print(
    //         'Published message: $payload to topic: ${message.variableHeader.topicName}');
    //   });
    // } else {
    //   print(
    //       'EMQX client connection failed - disconnecting, status is ${client.connectionStatus}');
    //   client.disconnect();
    // }

    return client;
  }

  static void onConnected() {
    print('Connected');
  }

  static void onDisconnected() {
    print('Disconnected');
  }

  static void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  static void onSubscribeFail(String topic) {
    print('Failed to subscribe topic: $topic');
  }

  static void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

  static void pong() {
    print('Ping response client callback invoked');
  }
}
