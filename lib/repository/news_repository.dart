import 'package:acta/models/news-response.dart';
import 'package:dio/dio.dart';

import './API.dart';

class NewsRepository {
  final Dio _dio = Dio();

  Future<NewsResponse> getTopHeadlines() async {
    final Response response =  await _dio.get<Map<String, dynamic>>('$API_URL');
    return NewsResponse.fromJson(response.data);
  }
}