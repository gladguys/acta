import 'package:acta/screens/at-base-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBySourceScreen extends StatelessWidget {
  Widget _buildSearchBySourceScreen() {
    return Center(
      child: Text('My search screen'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(title: 'Sources', body: _buildSearchBySourceScreen(), initialTab: 1,);
  }
}
