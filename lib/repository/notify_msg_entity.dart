import 'package:face_water_dispenser/generated/json/base/json_convert_content.dart';

class NotifyMsgEntity with JsonConvert<NotifyMsgEntity> {
	String date;
	String content;
	NotifyMsgEntity({this.date, this.content});
}
