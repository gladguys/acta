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
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Italianno',
            fontSize: 36.0,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: body,
      bottomNavigationBar: MainBottomNavigator(
        initialIndex: initialTab,
      ),
    );
  }
}
