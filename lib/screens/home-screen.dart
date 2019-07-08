import 'package:acta/enums/view_type.dart';
import 'package:acta/widgets/news-cards-list.dart';
import 'package:flutter/material.dart';
import 'package:acta/models/news-response.dart';
import 'package:flutter/cupertino.dart';
import 'package:acta/providers/news_provider.dart';

import 'at-base-screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsProvider _provider = NewsProvider();
  ViewType _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = ViewType.grid;
  }

  Future<NewsResponse> _getTopHeadlines() {
    return _provider.getTopHeadlines();
  }

  Widget _buildHomeScreen() {
    return FutureBuilder<NewsResponse>(
      future: _getTopHeadlines(),
      builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
        if (snapshot.hasData) {
          return NewsCardsList(
            news: snapshot.data,
            viewType: _viewType,
            newsRefresher: _getTopHeadlines,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Trending News',
      actions: <Widget>[
        IconButton(
            icon: Icon(_viewType == ViewType.grid
                ? Icons.view_agenda
                : Icons.dashboard),
            color: Colors.brown[300],
            onPressed: () {
              setState(() {
                _viewType =
                    _viewType == ViewType.grid ? ViewType.list : ViewType.grid;
              });
            })
      ],
      body: _buildHomeScreen(),
      initialTab: 0,
    );
  }
}
