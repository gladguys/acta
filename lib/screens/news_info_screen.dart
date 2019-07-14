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
      title: 'Acta',
      body: _buildNewsInfoScreen(),
      initialTab: 0,
      withCountryPicker: false,
    );
  }

  Widget _buildNewsInfoScreen() {
    return Container(
      padding: EdgeInsets.all(16.0),
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
          _buildBottom(),
        ],
      ),
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
      'Source: '+article.source.name ?? article.source.name,
      style: TextStyle(fontWeight: FontWeight.w500),
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
      style: TextStyle(fontSize: 14.0),
    );
  }

  Widget _buildDate() {
    return Text(
      DateFormat('EEE, dd MMM yyyy, HH:mm:ss').format(article.publishedAt).toString(),
      style: TextStyle(fontSize: 12.0),
    );
  }

  Widget _buildBottom() {
    return Column(
      children: <Widget>[
        _buildSource(),
        _buildDefaultSpacing(),
        _buildLaunchUrlButton(),
      ],
    );
  }

  Widget _buildLaunchUrlButton() {
    return RaisedButton(
      color: Colors.brown[700],
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))
      ),
      child: Text('See full content'),
      onPressed: _launchURL,
    );
  }

  Widget _buildDefaultSpacing({double height = 8.0}) {
    return SizedBox(
      height: height,
    );
  }
}
