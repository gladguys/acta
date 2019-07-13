import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';

import './API.dart';

class DioBuilder {
  factory DioBuilder() {
    return _singleton;
  }

  static final DioBuilder _singleton = DioBuilder();

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: API_BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 100000,
    headers: {'X-Api-Key': GlobalConfiguration().getString('api_key')},
  ));

  static Dio getDio() {
    return _dio;
  }
}
