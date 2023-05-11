import 'package:dio/dio.dart';

import 'dio_config.dart';
import 'end_point.dart';
import 'interceptor.dart';
class DioClient {
  Dio dio;
  DioClient(this.dio) {
    dio
      ..options.baseUrl = Endpoint.baseUrl
      ..options.connectTimeout = const Duration(seconds: DioConfig.connectTimeout )
      ..options.receiveTimeout =const Duration(seconds:  DioConfig.receiveTimeout)
      ..options.sendTimeout = const Duration(seconds: DioConfig.sendTimeout)
      ..options.responseType = ResponseType.json;
    dio.interceptors.add(ErrorInterceptor());
  }
}