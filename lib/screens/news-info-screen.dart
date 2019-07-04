import 'package:acta/models/article-response.dart';
import 'package:flutter/material.dart';
import 'package:acta/widgets/at-network-image.dart';
import 'at-base-screen.dart';

class NewsInfoScreen extends StatelessWidget {
  NewsInfoScreen({@required this.article});

  final ArticleResponse article;

  Widget _buildNewsInfoScreen() {
    return Column(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'News Info',
      body: _buildNewsInfoScreen(),
      initialTab: 0,
    );
  }
}
