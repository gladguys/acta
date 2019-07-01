import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acta/widgets/bottomNavigation/navigation-items.dart';
import 'package:acta/screens/home-screen.dart';
import 'package:acta/screens/search-by-source-screen.dart';

@immutable
class MainBottomNavigator extends StatelessWidget {
  MainBottomNavigator({this.initialIndex});

  final int initialIndex;

  void _navigateToTab(BuildContext context, int index) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (BuildContext context) => _findTabToNavigate(index)),
    );
  }

  Widget _findTabToNavigate(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchBySourceScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) => _navigateToTab(context, index),
      type: BottomNavigationBarType.fixed,
      currentIndex: initialIndex,
      items: navigationBarItems,
    );
  }
}
