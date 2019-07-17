import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:acta/blocs/news_bloc.dart';
import 'package:acta/enums/view_type.dart';
import 'package:acta/widgets/news_cards_list.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/providers/news_provider.dart';
import 'at_base_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = BlocProvider.getBloc<NewsBloc>();
  final _provider = NewsProvider();
  ViewType _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = ViewType.grid;
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Acta',
      actions: <Widget>[
        IconButton(
            icon: Icon(_viewType == ViewType.grid
                ? Icons.view_agenda
                : Icons.dashboard),
            color: Colors.brown[200],
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

  Future<void> _getTopHeadlines() {
    return _provider.getTopHeadlines().then((news) => _bloc.refreshNews(news));
  }

  Widget _buildHomeScreen() {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: StreamBuilder<bool>(
        stream: _bloc.newsObservable,
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
              viewType: _viewType,
              newsRefresher: _getTopHeadlines,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
