import 'package:acta/blocs/configs_bloc.dart';
import 'package:acta/blocs/news_bloc.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:acta/widgets/news_cards_list.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'at_base_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _provider = NewsProvider();

  final _newsBloc = BlocProvider.getBloc<NewsBloc>();
  final _configsBloc = BlocProvider.getBloc<ConfigsBloc>();

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: ATLabels.ACTA,
      body: _buildHomeScreen(),
      initialTab: 0,
    );
  }

  Future<void> _getTopHeadlines() {
    return _provider
        .getTopHeadlines()
        .then((news) => _newsBloc.refreshNews(news));
  }

  Widget _buildHomeScreen() {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: StreamBuilder<bool>(
        stream: _newsBloc.newsObservable,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
            _buildScreenFromStream(context, snapshot),
      ),
    );
  }

  Widget _buildScreenFromStream(
      BuildContext context, AsyncSnapshot<bool> snapshot) {
    if (snapshot.hasData) {
      return FutureBuilder(
        future: _provider.getTopHeadlines(),
        builder:
            (BuildContext context, AsyncSnapshot<NewsResponse> futureSnapshot) {
          if (futureSnapshot.hasData) {
            return NewsCardsList(
              news: futureSnapshot.data,
              viewType: _configsBloc.currentViewType,
              newsRefresher: _getTopHeadlines,
            );
          }
          return ATWaiting();
        },
      );
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }
    return ATWaiting();
  }
}
