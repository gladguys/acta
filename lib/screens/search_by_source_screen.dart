import 'package:acta/blocs/news_bloc.dart';
import 'package:acta/enums/source_logos.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/models/source_response.dart';
import 'package:acta/models/sources_response.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:acta/screens/at_base_screen.dart';
import 'package:acta/screens/news_by_source_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBySourceScreen extends StatelessWidget {
  final _bloc = BlocProvider.getBloc<NewsBloc>();
  final _provider = NewsProvider();

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: ATLabels.ACTA,
      subtitle: 'Sources',
      body: _buildSearchBySourceScreen(),
      initialTab: 1,
    );
  }

  Widget _buildSearchBySourceScreen() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: StreamBuilder(
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
          leading: Hero(
            tag: source.id,
            child: Container(
              width: 54.0,
              height: 54.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(27.0),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    SourcesLogo.getUrlById(source.id),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          title: Text(
            '${source.name}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
