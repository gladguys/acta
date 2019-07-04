import 'package:acta/models/article-response.dart';
import 'package:flutter/material.dart';
import 'package:acta/widgets/at-network-image.dart';
import 'package:intl/intl.dart';
import 'at-base-screen.dart';

class NewsInfoScreen extends StatelessWidget {
  NewsInfoScreen({@required this.article});

  final ArticleResponse article;

  Widget _buildNewsInfoScreen() {
    print(article.source.id);
    print(article.source.name);
    return Column(
      children: <Widget>[
        Text(
          article.source.name ?? article.source.name,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          article.title ?? article.title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Hero(
          tag: article.publishedAt,
          child: ATNetworkImage(imageUrl: article.urlToImage),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          article.content ?? article.content,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          DateFormat('dd-MM-yyyy HH:mm:ss').format(article.publishedAt).toString(),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          article.url,
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
