import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:acta/models/news-response.dart';

class NewsBloc extends BlocBase {

  NewsBloc();

  final BehaviorSubject<NewsResponse> _newsSubject = BehaviorSubject<NewsResponse>.seeded(null);

  Stream<NewsResponse> get newsObservable => _newsSubject.stream;

  void refreshNews(NewsResponse news) {
    _newsSubject.sink.add(news);
  }

  @override
  void dispose() {
    _newsSubject.close();
    super.dispose();
  }

}