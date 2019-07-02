import 'package:acta/screens/at-base-screen.dart';
import 'package:flutter/material.dart';

class SearchByTopicScreen extends StatelessWidget {
  Widget _buildSearchByTopicScreen() {
    return Center(
      child: Text('My SearchByTopic screen'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(title: 'Topic', body: _buildSearchByTopicScreen(), initialTab: 3,);
  }
}