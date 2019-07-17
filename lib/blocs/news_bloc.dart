import 'dart:async';
import 'package:acta/models/news_response.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc extends BlocBase {

  NewsBloc();

  final _newsCountrySubject = BehaviorSubject<bool>.seeded(true);
  final _newsRefresherSubject = BehaviorSubject<NewsResponse>.seeded(null);

  Stream<bool> get newsObservable => _newsCountrySubject.stream;
  Stream<NewsResponse> get newsRefresherObservable => _newsRefresherSubject.stream;

  void updateCountry() {
    _newsCountrySubject.sink.add(true);
  }

  void refreshNews(NewsResponse newsResponse) {
    _newsRefresherSubject.add(newsResponse);
  }

  @override
  void dispose() {
    _newsCountrySubject.close();
    _newsRefresherSubject.close();
    super.dispose();
  }

}