import 'package:acta/models/news-response.dart';
import 'package:acta/repository/news_repository.dart';

class NewsProvider {
  final NewsRepository _repository = NewsRepository();

  Future<NewsResponse> getTopHeadlines() async {
    return _repository.getTopHeadlines();
  }
}