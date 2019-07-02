import 'package:acta/models/article-response.dart';
import 'package:acta/models/news-response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acta/providers/news_provider.dart';
import 'at-base-screen.dart';

class HomeScreen extends StatelessWidget {
  final NewsProvider provider = NewsProvider();

  Widget _buildHomeScreen() {
    return FutureBuilder<NewsResponse>(
      future: provider.getTopHeadlines(),
      builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildTrendingNews(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildTrendingNews(NewsResponse newsResponse) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: ListView(children: _buildCardsList(newsResponse)),
    );
  }

  List<Card> _buildCardsList(NewsResponse newsResponse) {
    final List<Card> cards = [];
    final List<ArticleResponse> articlesWithInfo = newsResponse.articles
        .where((article) => article.content != null)
        .toList();

    for (ArticleResponse article in articlesWithInfo) {
      cards.add(Card(
          child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.network(article.urlToImage),
            SizedBox(
              height: 8.0,
            ),
            Text(
              article.title != null ? article.title : '',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      )));
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Home',
      body: _buildHomeScreen(),
      initialTab: 0,
    );
  }
}
