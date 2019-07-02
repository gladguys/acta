import 'package:acta/models/article-response.dart';

class NewsResponse {
  NewsResponse({this.status, this.totalResults, this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> parsedJson) {
    final List<Map<String, dynamic>> responseArticlesList =
        List<Map<String, dynamic>>.from(parsedJson['articles']);

    final List<ArticleResponse> articles = responseArticlesList
        .map((responseArticleJson) =>
            ArticleResponse.fromJson(responseArticleJson))
        .toList();

    return NewsResponse(
      status: parsedJson['status'],
      totalResults: parsedJson['totalResults'],
      articles: articles,
    );
  }

  final String status;
  final int totalResults;
  final List<ArticleResponse> articles;
}
