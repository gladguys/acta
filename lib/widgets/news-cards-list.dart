import 'package:flutter/material.dart';
import 'package:acta/models/news-response.dart';
import 'package:flutter/widgets.dart';
import 'package:acta/screens/news-info-screen.dart';
import 'package:acta/models/article-response.dart';
import 'package:acta/widgets/at-network-image.dart';

class NewsCardsList extends StatelessWidget {
  NewsCardsList({this.news});

  final NewsResponse news;

  Widget _buildNews(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: ListView(children: _buildCardsList(context, news)),
    );
  }

  List<Card> _buildCardsList(BuildContext context, NewsResponse newsResponse) {
    final List<Card> cards = [];
    final List<ArticleResponse> articlesWithInfo = newsResponse.articles
        .where((article) => article.content != null)
        .toList();

    for (ArticleResponse article in articlesWithInfo) {
      cards.add(_buildArticleCard(context, article));
    }

    return cards;
  }

  Widget _buildArticleCard(BuildContext context, ArticleResponse article) {
    return Card(
      child: GestureDetector(
        onTap: () => _navigateToNewsInfo(context, article),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Hero(
                tag: article.publishedAt,
                child: ATNetworkImage(imageUrl: article.urlToImage),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                article.title != null ? article.title : '',
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNewsInfo(BuildContext context, ArticleResponse article) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => NewsInfoScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildNews(context);
  }
}