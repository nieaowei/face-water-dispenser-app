import 'package:face_water_dispenser/generated/json/base/json_convert_content.dart';
import 'package:face_water_dispenser/generated/json/base/json_field.dart';

class MonitorMsgEntity with JsonConvert<MonitorMsgEntity> {
	@JSONField(name: "flow_limit")
	int flowLimit;
	@JSONField(name: "water_level")
	int waterLevel;
	int temp;
}
