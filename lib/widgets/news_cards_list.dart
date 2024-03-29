import 'package:acta/enums/view_type.dart';
import 'package:acta/models/article_response.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/widgets/at_network_image.dart';
import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'at_webview_container.dart';

class NewsCardsList extends StatelessWidget {
  NewsCardsList({@required this.news, this.viewType, this.newsRefresher});

  final NewsResponse news;
  final ViewType viewType;
  final Function newsRefresher;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: _buildNews(context),
    );
  }

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
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 4.0,
    );
  }

  Widget _buildArticleCardForList(
      BuildContext context, ArticleResponse article) {
    return AnimatedCard(
      child: Card(
        color: Colors.brown[50],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        clipBehavior: Clip.antiAlias,
        child: _actionsClickCard(context, article),
      ),
      duration: Duration(milliseconds: 300),
    );
  }

  Widget _buildArticleCardForGrid(
      BuildContext context, ArticleResponse article) {
    return AnimatedCard(
      child: Card(
        color: Colors.brown[50],
        elevation: 0,
        margin: EdgeInsets.all(0),
        child: _actionsClickCard(context, article),
      ),
      duration: Duration(milliseconds: 300),
    );
  }

  Widget _actionsClickCard(BuildContext context, ArticleResponse article) {
    return GestureDetector(
      onTap: () => _openNews(context, article),
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
      _widget = Center(child: _buildShimmerImage(article));
    } else {
      _widget = Container();
    }

    return _widget;
  }

  Widget _buildShimmerImage(ArticleResponse article) {
    return viewType == ViewType.grid
        ? ATNetworkImage(imageUrl: article.urlToImage)
        : ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500.0,
              maxHeight: 500.0,
            ),
            child: ATNetworkImage(
              imageUrl: article.urlToImage,
              width: 380,
              height: 180,
            ),
          );
  }

  Widget _buildTextOfCard(ArticleResponse article) {
    Widget _widget;

    if (article.urlToImage != null) {
      _widget = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          article.title != null ? article.title : '',
          textAlign:
              viewType == ViewType.grid ? TextAlign.start : TextAlign.center,
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

  void _openNews(BuildContext context, ArticleResponse article) {
    final String url = article.url;
    Navigation.navigateFromInside(
        context: context, screen: ATWebViewContainer(url: url));
  }
}
