import 'package:acta/blocs/configs_bloc.dart';
import 'package:acta/i18n/app_localizations.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:acta/widgets/news_cards_list.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'at_base_screen.dart';

class NewsByCategoryScreen extends StatelessWidget {
  NewsByCategoryScreen({@required this.id, @required this.name});

  final _provider = NewsProvider();
  final _configsBloc = BlocProvider.getBloc<ConfigsBloc>();

  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: ATLabels.ACTA,
      subtitle: '${AppLocalizations.of(context).category}: $name',
      body: _buildNewsByCategoryScreen(),
      initialTab: 2,
    );
  }

  Widget _buildNewsByCategoryScreen() {
    return FutureBuilder<NewsResponse>(
      future: _provider.getNewsByCategory(id),
      builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
        if (snapshot.hasData) {
          return NewsCardsList(
            news: snapshot.data,
            viewType: _configsBloc.currentViewType,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return ATWaiting();
      },
    );
  }
}
