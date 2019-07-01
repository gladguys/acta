import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acta/widgets/bottomNavigation/navigation-items.dart';
import 'package:acta/screens/home-screen.dart';
import 'package:acta/screens/search-by-source-screen.dart';

class MainBottomNavigator extends StatelessWidget {
  final int initialIndex;

  MainBottomNavigator({this.initialIndex});

  _navigateToTab(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _findTabToNavigate(index)),
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
