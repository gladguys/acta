import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:acta/widgets/bottomNavigation/navigation-items.dart';
import 'package:acta/screens/home-screen.dart';
import 'package:acta/screens/search-by-source-screen.dart';
import 'package:acta/screens/search-by-term-screen.dart';
import 'package:acta/screens/search-by-category-screen.dart';
import 'package:acta/utils/navigation.dart';

@immutable
class MainBottomNavigator extends StatelessWidget {
  MainBottomNavigator({this.initialIndex});

  final int initialIndex;

  void _navigateToTab(BuildContext context, int index) {
    Navigation.navigateFromMenu(
      context: context,
      screen: _findTabToNavigate(index),
    );
  }

  Widget _findTabToNavigate(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchBySourceScreen();
      case 2:
        return SearchByTermScreen();
      case 3:
        return SearchByCategoryScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: initialIndex,
      items: navigationBarItems,
      height: 56,
      color: Theme.of(context).accentColor,
      backgroundColor: Colors.transparent,
      onTap: (int index) => _navigateToTab(context, index),
    );
  }
}
