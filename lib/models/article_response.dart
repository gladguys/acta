import './news_source.dart';

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
      source: NewsSource.fromJson(parsedJson['source']),
      author: parsedJson['author'],
      title: parsedJson['title'],
      url: parsedJson['url'],
      urlToImage: parsedJson['urlToImage'],
      publishedAt: DateTime.parse(parsedJson['publishedAt']),
      content: parsedJson['content'],
    );
  }

  final NewsSource source;
  final String author;
  final String title;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;
}
