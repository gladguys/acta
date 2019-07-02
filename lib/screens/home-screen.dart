import 'package:acta/models/news-response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acta/providers/news_provider.dart';
import 'at-base-screen.dart';

class HomeScreen extends StatelessWidget {
  final NewsProvider provider = NewsProvider();

  Widget _buildHomeScreen() {
    return FutureBuilder<NewsResponse>(
      future: provider.getTopHeadlines(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.totalResults.toString());
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: 'Home',
      body: _buildHomeScreen(),
      initialTab: 0,
    );
  }
}