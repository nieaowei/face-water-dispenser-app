import 'package:dio/dio.dart';

class HttpUtil {
  static final String host = "https://www.baidu.com";
  static final int port = 8080;
  final Dio _dio = Dio(BaseOptions(baseUrl: host ));
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
}
