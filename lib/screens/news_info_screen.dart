import 'package:acta/utils/navigation.dart';
import 'package:acta/widgets/at_webview_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:acta/models/article_response.dart';
import 'package:acta/widgets/at_network_image.dart';
import 'at_base_screen.dart';

class NewsInfoScreen extends StatelessWidget {
  NewsInfoScreen({@required this.article});

  final ArticleResponse article;

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Acta',
      body: _buildNewsInfoScreen(context),
      initialTab: 0,
    );
  }

  Widget _buildNewsInfoScreen(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      child: ListView(
        children: <Widget>[
          _buildTitle(),
          _buildDefaultSpacing(),
          _buildDate(),
          _buildDefaultSpacing(height: 16.0),
          _buildImage(),
          _buildDefaultSpacing(),
          _buildContent(),
          _buildDefaultSpacing(height: 24.0),
          _buildBottom(context),
        ],
      ),
    );
  }

  Future<void> _launchURL(BuildContext context) async {
    final String url = article.url;
    Navigation.navigateFromInside(context: context, screen: ATWebViewContainer(url: url));
  }

  Widget _buildSource() {
    return Text(
      'Source: ${article.source.name}',
      style: TextStyle(fontWeight: FontWeight.w500),
    );
  }

  Widget _buildTitle() {
    return Text(
      article.title ?? '',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: '${article.publishedAt.toString()?? '' }${article.author ?? article.title}',
      child: ATNetworkImage(imageUrl: article.urlToImage),
    );
  }

  Widget _buildContent() {
    return Text(
      article.content ?? article.content,
      style: TextStyle(fontSize: 14.0),
    );
  }

  Widget _buildDate() {
    return Text(
      DateFormat('EEE, dd MMM yyyy, HH:mm:ss').format(article.publishedAt).toString(),
      style: TextStyle(fontSize: 12.0),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSource(),
        _buildDefaultSpacing(),
        _buildLaunchUrlButton(context),
      ],
    );
  }

  Widget _buildLaunchUrlButton(BuildContext context) {
    return RaisedButton(
      color: Colors.brown[700],
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: Text('See full content'),
      onPressed: () => _launchURL(context),
    );
  }

  Widget _buildDefaultSpacing({double height = 8.0}) {
    return SizedBox(
      height: height,
    );
  }
}
