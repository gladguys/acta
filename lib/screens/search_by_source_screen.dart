import 'package:acta/widgets/at_waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:acta/blocs/news_bloc.dart';
import 'package:acta/models/source_response.dart';
import 'package:acta/models/sources_response.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/screens/at_base_screen.dart';
import 'package:acta/screens/news_by_source_screen.dart';

class SearchBySourceScreen extends StatelessWidget {
  final _bloc = BlocProvider.getBloc<NewsBloc>();
  final _provider = NewsProvider();

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Sources',
      body: _buildSearchBySourceScreen(),
      initialTab: 1,
    );
  }

  Widget _buildSearchBySourceScreen() {
    return StreamBuilder(
      stream: _bloc.newsObservable,
      initialData: true,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
          _buildScreenFromStream(context, snapshot),
    );
  }

  Widget _buildScreenFromStream(
      BuildContext context, AsyncSnapshot<bool> snapshot) {
    if (snapshot.hasData) {
      return FutureBuilder<SourcesResponse>(
        future: _provider.getAllSources(),
        builder:
            (BuildContext context, AsyncSnapshot<SourcesResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildSourcesList(context, snapshot.data);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return ATWaiting();
        },
      );
    }
    return ATWaiting();
  }

  Widget _buildSourcesList(
      BuildContext context, SourcesResponse sourcesResponse) {
    return ListView.builder(
      itemCount: sourcesResponse.sources.length,
      itemBuilder: (context, index) =>
          _buildSourceTile(context, sourcesResponse.sources[index]),
    );
  }

  Widget _buildSourceTile(BuildContext context, SourceResponse source) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('${source.name}'),
          subtitle: Text('${source.description}'),
          onTap: () => _navigateToNewsBySource(context, source),
        ),
        Divider(),
      ],
    );
  }

  void _navigateToNewsBySource(BuildContext context, SourceResponse source) {
    Navigation.navigateFromInside(
      context: context,
      screen: NewsBySourceScreen(
        id: source.id,
        name: source.name,
      ),
    );
  }
}
