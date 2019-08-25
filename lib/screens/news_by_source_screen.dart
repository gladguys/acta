import 'package:acta/enums/source_logos.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/models/news_response.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:acta/widgets/news_cards_list.dart';
import 'package:flutter/material.dart';

import 'at_base_screen.dart';

class NewsBySourceScreen extends StatelessWidget {
  NewsBySourceScreen({@required this.id, @required this.name});

  final NewsProvider _provider = NewsProvider();
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
            padding: EdgeInsets.only(top: 12.0),
            width: 100,
            height: 100,
            child: Image.network(SourcesLogo.getUrlById(id)),
          ),
        ),
      ],
      body: _buildNewsBySourceScreen(),
      initialTab: 1,
    );
  }

  Widget _buildNewsBySourceScreen() {
    return FutureBuilder<NewsResponse>(
      future: _provider.getTopHeadlinesFromSource(id),
      builder: (BuildContext context, AsyncSnapshot<NewsResponse> snapshot) {
        if (snapshot.hasData) {
          return NewsCardsList(news: snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return ATWaiting();
      },
    );
  }
}
