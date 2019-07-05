import 'package:acta/models/news-response.dart';
import 'package:acta/models/sources-response.dart';
import 'package:acta/repository/news_repository.dart';

class NewsProvider {
  final NewsRepository _repository = NewsRepository();

  Future<NewsResponse> getTopHeadlines() async {
    return _repository.getTopHeadlines();
  }

  Future<NewsResponse> getTopHeadlinesFromSource(String sourceId) async {
    return _repository.getTopHeadlinesFromSource(sourceId);
  }

  Future<NewsResponse> getNewsByCategory(String categoryId) async {
    return _repository.getNewsByCategory(categoryId);
  }

  Future<SourcesResponse> getAllSources() async {
    return _repository.getAllSources();
  }
}
