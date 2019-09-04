import 'package:acta/blocs/configs_bloc.dart';
import 'package:acta/enums/source_logos.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:acta/widgets/news_cards_list.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'at_base_screen.dart';

class NewsBySourceScreen extends StatelessWidget {
  NewsBySourceScreen({@required this.id, @required this.name});

  final NewsProvider _provider = NewsProvider();
  final _configsBloc = BlocProvider.getBloc<ConfigsBloc>();

  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: ATLabels.ACTA,
      subtitle: name,
      actions: <Widget>[
        Hero(
          tag: id,
          child: Container(
            margin: const EdgeInsets.only(right: 16.0),
            width: 60.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.brown[100]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  SourcesLogo.getUrlById(id),
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
      body: _buildNewsBySourceScreen(),
      initialTab: 1,
    );
  }

  Widget _buildNewsBySourceScreen() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: FutureBuilder<NewsResponse>(
        future: _provider.getTopHeadlinesFromSource(id),
        builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
          if (snapshot.hasData) {
            return NewsCardsList(
              news: snapshot.data,
              viewType: _configsBloc.currentViewType,
              newsRefresher: () => _provider.getTopHeadlinesFromSource(id),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return ATWaiting();
        },
      ),
    );
  }
}
