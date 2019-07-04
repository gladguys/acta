import 'package:acta/models/news-response.dart';
import 'package:acta/repository/dio-builder.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:dio/dio.dart';

import './API.dart';

class NewsRepository {
  final Dio _dio = DioBuilder.getDio();

  Future<NewsResponse> getTopHeadlines() async {
    final String apiKey = GlobalConfiguration().getString('api_key');
    final Response response = await _dio
        .get<Map<String, dynamic>>('$TOP_HEADLINES?$COUNTRY=us&apiKey=$apiKey');
    return NewsResponse.fromJson(response.data);
  }
}
