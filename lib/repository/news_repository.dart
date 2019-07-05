import 'package:acta/models/news-response.dart';
import 'package:acta/models/sources-response.dart';
import 'package:acta/repository/dio-builder.dart';
import 'package:dio/dio.dart';

import './API.dart';

class NewsRepository {
  final Dio _dio = DioBuilder.getDio();

  Future<NewsResponse> getTopHeadlines() async {
    final Response response =
        await _dio.get<Map<String, dynamic>>('$TOP_HEADLINES?$COUNTRY=us');
    return NewsResponse.fromJson(response.data);
  }

  Future<NewsResponse> getTopHeadlinesFromSource(String sourceId) async {
    final Response response = await _dio
        .get<Map<String, dynamic>>('$TOP_HEADLINES?$SOURCES=$sourceId');
    return NewsResponse.fromJson(response.data);
  }

  Future<NewsResponse> getNewsByCategory(String categoryId) async {
    final Response response = await _dio.get<Map<String, dynamic>>(
        '$TOP_HEADLINES?$CATEGORY=$categoryId&$COUNTRY=us');
    return NewsResponse.fromJson(response.data);
  }

  Future<SourcesResponse> getAllSources() async {
    final Response response =
        await _dio.get<Map<String, dynamic>>('$ALL_SOURCES?$COUNTRY=us');
    return SourcesResponse.fromJson(response.data);
  }

  Future<NewsResponse> getNewsByTerm(String term) async {
    final Response response = await _dio.get<Map<String, dynamic>>('$EVERYTHING?q=$term');
    return NewsResponse.fromJson(response.data);
  }
}
