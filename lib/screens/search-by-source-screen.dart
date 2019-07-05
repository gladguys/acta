import 'package:acta/models/source-response.dart';
import 'package:acta/models/sources-response.dart';
import 'package:acta/screens/at-base-screen.dart';
import 'package:acta/screens/news-by-source-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:flutter/material.dart';

class SearchBySourceScreen extends StatelessWidget {
  final NewsProvider _provider = NewsProvider();

  Widget _buildSearchBySourceScreen() {
    return FutureBuilder<SourcesResponse>(
      future: _provider.getAllSources(),
      builder: (BuildContext context, AsyncSnapshot<SourcesResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildSourcesList(context, snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
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
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => NewsBySourceScreen(
              id: source.id,
              name: source.name,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Sources',
      body: _buildSearchBySourceScreen(),
      initialTab: 1,
    );
  }
}
