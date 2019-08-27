import 'package:acta/models/news_response.dart';
import 'package:acta/models/sources_response.dart';
import 'package:acta/repository/dio_builder.dart';
import 'package:global_configuration/global_configuration.dart';

import './API.dart';

class NewsRepository {
  final _dio = DioBuilder.getDio();

  Future<NewsResponse> getTopHeadlines() async {
    final String country = GlobalConfiguration().get('country');
    final response = await _dio
        .get<Map<String, dynamic>>('$TOP_HEADLINES?$COUNTRY=$country');
    return NewsResponse.fromJson(response.data);
  }

  Future<NewsResponse> getTopHeadlinesFromSource(String sourceId) async {
    final response = await _dio
        .get<Map<String, dynamic>>('$TOP_HEADLINES?$SOURCES=$sourceId');
    return NewsResponse.fromJson(response.data);
  }

  Future<NewsResponse> getNewsByCategory(String categoryId) async {
    final country = GlobalConfiguration().get('country');
    final response = await _dio.get<Map<String, dynamic>>(
        '$TOP_HEADLINES?$CATEGORY=$categoryId&$COUNTRY=$country');
    return NewsResponse.fromJson(response.data);
  }

  Future<SourcesResponse> getAllSources() async {
    final country = GlobalConfiguration().get('country');
    final response =
        await _dio.get<Map<String, dynamic>>('$ALL_SOURCES?$COUNTRY=$country');
    return SourcesResponse.fromJson(response.data);
  }

  Future<NewsResponse> getNewsByTerm(String term) async {
    final country = GlobalConfiguration().get('country');
    final response = await _dio
        .get<Map<String, dynamic>>('$EVERYTHING?q=$term?$COUNTRY=$country');
    return NewsResponse.fromJson(response.data);
  }
}
