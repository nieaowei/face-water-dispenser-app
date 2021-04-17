// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:face_water_dispenser/repository/monitor_used_water_time_msg_entity.dart';
import 'package:face_water_dispenser/generated/json/monitor_used_water_time_msg_entity_helper.dart';
import 'package:face_water_dispenser/repository/notify_msg_entity.dart';
import 'package:face_water_dispenser/generated/json/notify_msg_entity_helper.dart';
import 'package:face_water_dispenser/repository/monitor_msg_entity.dart';
import 'package:face_water_dispenser/generated/json/monitor_msg_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case MonitorUsedWaterTimeMsgEntity:
				return monitorUsedWaterTimeMsgEntityFromJson(data as MonitorUsedWaterTimeMsgEntity, json) as T;
			case NotifyMsgEntity:
				return notifyMsgEntityFromJson(data as NotifyMsgEntity, json) as T;
			case MonitorMsgEntity:
				return monitorMsgEntityFromJson(data as MonitorMsgEntity, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case MonitorUsedWaterTimeMsgEntity:
				return monitorUsedWaterTimeMsgEntityToJson(data as MonitorUsedWaterTimeMsgEntity);
			case NotifyMsgEntity:
				return notifyMsgEntityToJson(data as NotifyMsgEntity);
			case MonitorMsgEntity:
				return monitorMsgEntityToJson(data as MonitorMsgEntity);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (MonitorUsedWaterTimeMsgEntity).toString()){
			return MonitorUsedWaterTimeMsgEntity().fromJson(json);
		}	else if(type == (NotifyMsgEntity).toString()){
			return NotifyMsgEntity().fromJson(json);
		}	else if(type == (MonitorMsgEntity).toString()){
			return MonitorMsgEntity().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<MonitorUsedWaterTimeMsgEntity>[] is M){
			return data.map<MonitorUsedWaterTimeMsgEntity>((e) => MonitorUsedWaterTimeMsgEntity().fromJson(e)).toList() as M;
		}	else if(<NotifyMsgEntity>[] is M){
			return data.map<NotifyMsgEntity>((e) => NotifyMsgEntity().fromJson(e)).toList() as M;
		}	else if(<MonitorMsgEntity>[] is M){
			return data.map<MonitorMsgEntity>((e) => MonitorMsgEntity().fromJson(e)).toList() as M;
		}
		throw Exception("not fond");
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}