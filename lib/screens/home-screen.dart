import 'package:acta/widgets/news-cards-list.dart';
import 'package:flutter/material.dart';
import 'package:acta/models/news-response.dart';
import 'package:flutter/cupertino.dart';
import 'package:acta/providers/news_provider.dart';

import 'at-base-screen.dart';

class HomeScreen extends StatelessWidget {
  final NewsProvider _provider = NewsProvider();

  Widget _buildHomeScreen() {
    return FutureBuilder<NewsResponse>(
      future: _provider.getTopHeadlines(),
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
      title: 'Trending News',
      body: _buildHomeScreen(),
      initialTab: 0,
    );
  }
}
