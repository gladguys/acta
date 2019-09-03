import 'package:acta/i18n/at_labels.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:acta/widgets/news_cards_list.dart';
import 'package:flutter/material.dart';

import 'at_base_screen.dart';

class NewsByCategoryScreen extends StatelessWidget {
  NewsByCategoryScreen({@required this.id, @required this.name});

  final _provider = NewsProvider();
  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: ATLabels.ACTA,
      subtitle: '${ATLabels.CATEGORY}: $name',
      body: _buildNewsByCategoryScreen(),
      initialTab: 2,
    );
  }

  Widget _buildNewsByCategoryScreen() {
    return FutureBuilder<NewsResponse>(
      future: _provider.getNewsByCategory(id),
      builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return NewsCardsList(
            news: snapshot.data,
            newsRefresher: _getTopHeadlines,);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return ATWaiting();
      },
    );
  }

   Future<NewsResponse> _getTopHeadlines() {
    return _provider.getNewsByCategory(id);
  }
  
}
