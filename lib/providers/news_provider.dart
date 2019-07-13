import 'package:acta/models/news_response.dart';
import 'package:acta/models/sources_response.dart';
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

  Future<NewsResponse> getNewsByTerm(String term) async {
    return _repository.getNewsByTerm(term);
  }
}
