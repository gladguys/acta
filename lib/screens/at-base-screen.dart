import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/bottomNavigation/main-bottom-navigator.dart';

class ATBaseScreen extends StatelessWidget {
  ATBaseScreen(
      {@required this.title, @required this.body, this.initialTab = 0});

  final String title;
  final Widget body;
  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
      bottomNavigationBar: MainBottomNavigator(
        initialIndex: initialTab,
      ),
    );
  }
}
