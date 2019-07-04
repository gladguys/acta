import './source.dart';

class ArticleResponse {
  ArticleResponse(
      {this.source,
      this.author,
      this.title,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory ArticleResponse.fromJson(Map<String, dynamic> parsedJson) {
    return ArticleResponse(
      source: Source.fromJson(parsedJson['source']),
      author: parsedJson['author'],
      title: parsedJson['title'],
      url: parsedJson['url'],
      urlToImage: parsedJson['urlToImage'],
      publishedAt: DateTime.parse(parsedJson['publishedAt']),
      content: parsedJson['content'],
    );
  }

  final Source source;
  final String author;
  final String title;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;
}
