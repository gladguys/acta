import 'package:acta/screens/at-base-screen.dart';
import 'package:flutter/material.dart';

class SearchByTermScreen extends StatelessWidget {
  Widget _buildSearchByTermScreen() {
    return Center(
      child: Text('My SearchByTerm screen'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(title: 'My SearchByTerm screen', body: _buildSearchByTermScreen(), initialTab: 2,);
  }
}