import 'package:acta/models/news-response.dart';
import 'package:acta/widgets/news-cards-list.dart';
import 'package:flutter/material.dart';
import 'package:acta/providers/news_provider.dart';
import 'at-base-screen.dart';

class NewsBySourceScreen extends StatelessWidget {
  NewsBySourceScreen({@required this.id, @required this.name});

  final NewsProvider _provider = NewsProvider();
  final String id;
  final String name;

  Widget _buildNewsBySourceScreen() {
    return FutureBuilder<NewsResponse>(
      future: _provider.getTopHeadlinesFromSource(id),
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
      title: name,
      body: _buildNewsBySourceScreen(),
      initialTab: 1,
    );
  }
}
