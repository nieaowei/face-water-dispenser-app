import 'package:face_water_dispenser/repository/notify_msg_entity.dart';

notifyMsgEntityFromJson(NotifyMsgEntity data, Map<String, dynamic> json) {
	if (json['date'] != null) {
		data.date = json['date'].toString();
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
	return data;
}

Map<String, dynamic> notifyMsgEntityToJson(NotifyMsgEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['date'] = entity.date;
	data['content'] = entity.content;
	return data;
}