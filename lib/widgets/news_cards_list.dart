import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/models/article_response.dart';
import 'package:acta/widgets/at_network_image.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/screens/news_info_screen.dart';

class NewsCardsList extends StatelessWidget {
  NewsCardsList(
      {@required this.news, this.newsRefresher});

  final NewsResponse news;
  final Function newsRefresher;

  @override
  Widget build(BuildContext context) {
    return _buildNews(context);
  }

  Widget _buildNews(BuildContext context) {
    final List<ArticleResponse> articles =
        news.articles.where((article) => article.content != null).toList();

    if (newsRefresher != null) {
      return LiquidPullToRefresh(
          onRefresh: newsRefresher,
          child: _buildCardsGrid(context, articles));
    }
    return _buildCardsGrid(context, articles);
  }

  Widget _buildCardsGrid(BuildContext context, List<ArticleResponse> articles) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) =>
          _buildArticleCardForGrid(context, articles[index]),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 4.0,
    );
  }

  Widget _buildArticleCardForGrid(
      BuildContext context, ArticleResponse article) {
    return Card(
      color: Colors.brown[50],
      elevation: 0,
      margin: EdgeInsets.all(0),
      child: _actionsClickCard(context, article),
    );
  }

  Widget _actionsClickCard(BuildContext context, ArticleResponse article) {
    return GestureDetector(
      onTap: () => _navigateToNewsInfo(context, article),
      child: Column(
        children: <Widget>[
          _buildImageOfCard(article),
          _buildTextOfCard(article)
        ],
      ),
    );
  }

  Widget _buildImageOfCard(ArticleResponse article) {
    Widget _widget;

    if (article.urlToImage != null) {
      _widget = Hero(
        tag: '${article.publishedAt.toString() ?? ''}${article.author ?? article.title}',
        child: _buildShimmerImage(article),
      );
    } else {
      _widget = Container();
    }

    return _widget;
  }

  Widget _buildShimmerImage(ArticleResponse article) {
    return ATNetworkImage(imageUrl: article.urlToImage);
  }

  Widget _buildTextOfCard(ArticleResponse article) {
    Widget _widget;

    if (article.urlToImage != null) {
      _widget = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          article.title != null ? article.title : '',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 14.0),
        ),
      );
    } else {
      _widget = Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Text(
          article.title != null ? article.title : '',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }

    return _widget;
  }

  void _navigateToNewsInfo(BuildContext context, ArticleResponse article) {
    Navigation.navigateFromInside(
        context: context, screen: NewsInfoScreen(article: article));
  }
}
