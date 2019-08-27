import 'package:acta/i18n/at_labels.dart';
import 'package:acta/screens/settings_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/widgets/at_waiting.dart';
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
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _provider = NewsProvider();
  ViewType _viewType;

  final _newsBloc = BlocProvider.getBloc<NewsBloc>();

  @override
  void initState() {
    super.initState();
    _viewType = ViewType.grid;
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: ATLabels.ACTA,
      actions: <Widget>[
        _buildSwitchViewTypeIcon(),
        _buildSettingsIcon(),
      ],
      body: _buildHomeScreen(),
      initialTab: 0,
    );
  }

  Widget _buildSwitchViewTypeIcon() {
    return IconButton(
      icon: Icon(
          _viewType == ViewType.grid ? Icons.view_agenda : Icons.dashboard),
      color: Colors.brown[300],
      onPressed: _changeViewType,
    );
  }

  void _changeViewType() {
    setState(() {
      _viewType = _viewType == ViewType.grid ? ViewType.list : ViewType.grid;
    });
  }

  Widget _buildSettingsIcon() {
    return IconButton(
      icon: Icon(Icons.settings),
      color: Colors.brown[300],
      onPressed: () => Navigation.navigateFromInside(
        context: context,
        screen: SettingsScreen(),
      ),
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
              viewType: _viewType,
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
