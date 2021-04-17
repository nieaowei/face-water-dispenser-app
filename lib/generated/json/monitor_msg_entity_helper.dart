import 'package:face_water_dispenser/repository/monitor_msg_entity.dart';

monitorMsgEntityFromJson(MonitorMsgEntity data, Map<String, dynamic> json) {
	if (json['flow_limit'] != null) {
		data.flowLimit = json['flow_limit'] is String
				? int.tryParse(json['flow_limit'])
				: json['flow_limit'].toInt();
	}
	if (json['water_level'] != null) {
		data.waterLevel = json['water_level'] is String
				? int.tryParse(json['water_level'])
				: json['water_level'].toInt();
	}
	if (json['temp'] != null) {
		data.temp = json['temp'] is String
				? int.tryParse(json['temp'])
				: json['temp'].toInt();
	}
	return data;
}

Map<String, dynamic> monitorMsgEntityToJson(MonitorMsgEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['flow_limit'] = entity.flowLimit;
	data['water_level'] = entity.waterLevel;
	data['temp'] = entity.temp;
	return data;
}