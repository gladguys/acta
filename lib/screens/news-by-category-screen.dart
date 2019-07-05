import 'package:acta/models/news-response.dart';
import 'package:acta/widgets/news-cards-list.dart';
import 'package:flutter/material.dart';
import 'package:acta/providers/news_provider.dart';
import 'at-base-screen.dart';

class NewsByCategoryScreen extends StatelessWidget {
  NewsByCategoryScreen({@required this.id, @required this.name});

  final NewsProvider _provider = NewsProvider();
  final String id;
  final String name;

  Widget _buildNewsByCategoryScreen() {
    return FutureBuilder<NewsResponse>(
      future: _provider.getNewsByCategory(id),
      builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
        if (snapshot.hasData) {
          return NewsCardsList(news: snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Category: $name',
      body: _buildNewsByCategoryScreen(),
      initialTab: 3,
    );
  }
}
