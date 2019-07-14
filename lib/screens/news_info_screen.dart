import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:acta/models/article_response.dart';
import 'package:acta/widgets/at_network_image.dart';
import 'at_base_screen.dart';

class NewsInfoScreen extends StatelessWidget {
  NewsInfoScreen({@required this.article});

  final ArticleResponse article;

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'News Info',
      body: _buildNewsInfoScreen(),
      initialTab: 0,
    );
  }

  Future<void> _launchURL() async {
    final String url = article.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSource() {
    return Text(
      article.source.name ?? article.source.name,
      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTitle() {
    return Text(
      article.title ?? article.title,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
      style: TextStyle(fontSize: 16.0),
    );
  }

  Widget _buildDate() {
    return Text(
      DateFormat('dd-MM-yyyy HH:mm:ss').format(article.publishedAt).toString(),
    );
  }

  Widget _buildLaunchUrlButton() {
    return RaisedButton(
      child: Text('Full content'),
      onPressed: _launchURL,
    );
  }

  Widget _buildDefaultSpacing() {
    return SizedBox(
      height: 8.0,
    );
  }

  Widget _buildNewsInfoScreen() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          _buildSource(),
          _buildDefaultSpacing(),
          _buildTitle(),
          _buildImage(),
          _buildDefaultSpacing(),
          _buildContent(),
          _buildDefaultSpacing(),
          _buildDate(),
          _buildDefaultSpacing(),
          _buildLaunchUrlButton(),
        ],
      ),
    );
  }
}
