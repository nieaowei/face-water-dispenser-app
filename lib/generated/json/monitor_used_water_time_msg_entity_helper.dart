import 'package:face_water_dispenser/repository/monitor_used_water_time_msg_entity.dart';

monitorUsedWaterTimeMsgEntityFromJson(MonitorUsedWaterTimeMsgEntity data, Map<String, dynamic> json) {
	if (json['hour'] != null) {
		data.hour = json['hour'] is String
				? double.tryParse(json['hour'])
				: json['hour'].toDouble();
	}
	if (json['val'] != null) {
		data.val = json['val'] is String
				? double.tryParse(json['val'])
				: json['val'].toDouble();
	}
	return data;
}

Map<String, dynamic> monitorUsedWaterTimeMsgEntityToJson(MonitorUsedWaterTimeMsgEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['hour'] = entity.hour;
	data['val'] = entity.val;
	return data;
}