import 'package:acta/models/news-response.dart';
import 'package:acta/utils/secrets/secrets_loader.dart';
import 'package:dio/dio.dart';

import './API.dart';

class NewsRepository {
  NewsRepository() {
    SecretLoader(secretPath: 'secrets.json').load().then((val) {
      secret = val.apiKey;
    });
  }

  final Dio _dio = Dio();
  String secret;

  Future<NewsResponse> getTopHeadlines() async {
    final Response response =
        await _dio.get<Map<String, dynamic>>('$API_URL&apiKey=$secret');
    return NewsResponse.fromJson(response.data);
  }
}
