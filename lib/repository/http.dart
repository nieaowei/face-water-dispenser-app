import 'package:dio/dio.dart';
import 'package:face_water_dispenser/generated/json/base/json_convert_content.dart';

class HttpUtil {
  static final String host = "http://172.16.20.78:4523/mock/361063";
  static final int port = 8080;
  final Dio _dio = Dio(BaseOptions(
      baseUrl: host,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      sendTimeout: 3000));

  HttpUtil._internal() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["token"] = "123";
        print(options.headers);
        print(options.uri.toString());
        print(options.baseUrl);
        handler.next(options);
      },
    ));
  }

  static HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  static Dio getInstance() {
    return _instance._dio;
  }
}

class Resp<T> {
  int code;
  String msg;
  T data;

  Resp({this.code, this.msg, this.data});

  Resp.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] != 'null') {
      data = JsonConvert.fromJsonAsT<T>(json['data']);
    }

    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}
