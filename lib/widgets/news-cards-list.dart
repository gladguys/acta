import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:acta/models/news-response.dart';
import 'package:acta/models/article-response.dart';
import 'package:acta/enums/view_type.dart';
import 'package:acta/screens/news-info-screen.dart';
import 'package:acta/widgets/at-network-image.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:acta/utils/navigation.dart';

class NewsCardsList extends StatelessWidget {
  NewsCardsList(
      {@required this.news, @required this.viewType, this.newsRefresher});

  final NewsResponse news;
  final ViewType viewType;
  final Function newsRefresher;

  Widget _buildNews(BuildContext context) {
    final List<ArticleResponse> articles =
        news.articles.where((article) => article.content != null).toList();

    if (newsRefresher != null) {
      return LiquidPullToRefresh(
          onRefresh: newsRefresher,
          child: _buildNewsWithType(context, articles));
    }
    return _buildNewsWithType(context, articles);
  }

  Widget _buildNewsWithType(
      BuildContext context, List<ArticleResponse> articles) {
    return viewType == ViewType.grid
        ? _buildCardsGrid(context, articles)
        : _buildCardsList(context, articles);
  }

  Widget _buildCardsList(BuildContext context, List<ArticleResponse> articles) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) =>
          _buildArticleCardForList(context, articles[index]),
    );
  }

  Widget _buildCardsGrid(BuildContext context, List<ArticleResponse> articles) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) =>
          _buildArticleCardForGrid(context, articles[index]),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  Widget _buildArticleCardForList(
      BuildContext context, ArticleResponse article) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        color: Colors.brown[100],
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: _actionsClickCard(context, article),
      ),
    );
  }

  Widget _buildArticleCardForGrid(
      BuildContext context, ArticleResponse article) {
    return Card(
      color: Colors.brown[50],
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
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
      _widget = Container(
        margin: EdgeInsets.only(bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Hero(
            tag: article.publishedAt,
            child: ATNetworkImage(imageUrl: article.urlToImage),
          ),
        ),
      );
    } else {
      _widget = Container();
    }

    return _widget;
  }

  Widget _buildTextOfCard(ArticleResponse article) {
    Widget _widget;

    if (article.urlToImage != null) {
      _widget = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          article.title != null ? article.title : '',
          textAlign:
              viewType == ViewType.grid ? TextAlign.justify : TextAlign.center,
          style: TextStyle(fontSize: viewType == ViewType.grid ? 14.0 : 16.0),
        ),
      );
    } else {
      _widget = Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Text(
          article.title != null ? article.title : '',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: viewType == ViewType.grid ? 18.0 : 20.0),
        ),
      );
    }

    return _widget;
  }

  void _navigateToNewsInfo(BuildContext context, ArticleResponse article) {
    Navigation.navigateFromInside(
      context: context,
      screen: NewsInfoScreen(article: article)
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildNews(context);
  }
}
