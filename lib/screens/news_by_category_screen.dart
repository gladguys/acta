import 'package:acta/widgets/at_waiting.dart';
import 'package:flutter/material.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/widgets/news_cards_list.dart';
import 'at_base_screen.dart';

class NewsByCategoryScreen extends StatelessWidget {
  NewsByCategoryScreen({@required this.id, @required this.name});

  final _provider = NewsProvider();
  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Acta',
      subtitle: 'Category: $name',
      body: _buildNewsByCategoryScreen(),
      initialTab: 3,
    );
  }

  Widget _buildNewsByCategoryScreen() {
    return FutureBuilder<NewsResponse>(
      future: _provider.getNewsByCategory(id),
      builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
        if (snapshot.hasData) {
          return NewsCardsList(news: snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return ATWaiting();
      },
    );
  }
}
