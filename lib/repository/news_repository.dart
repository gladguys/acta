import 'package:acta/models/news-response.dart';
import 'package:acta/repository/dio-builder.dart';
import 'package:dio/dio.dart';

import './API.dart';

class NewsRepository {
  final Dio _dio = DioBuilder.getDio();

  Future<NewsResponse> getTopHeadlines() async {
    final Response response = await _dio
        .get<Map<String, dynamic>>('$TOP_HEADLINES?$COUNTRY=us&$API_KEY');
    return NewsResponse.fromJson(response.data);
  }
}
