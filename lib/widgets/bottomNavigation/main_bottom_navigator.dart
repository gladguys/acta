import 'package:acta/screens/home_screen.dart';
import 'package:acta/screens/search_by_category_screen.dart';
import 'package:acta/screens/search_by_source_screen.dart';
import 'package:acta/screens/settings_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/widgets/bottomNavigation/navigation_items.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class MainBottomNavigator extends StatelessWidget {
  MainBottomNavigator({this.initialIndex});

  final int initialIndex;

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

  void _navigateToTab(BuildContext context, int index) {
    Navigation.navigateFromMenu(
      context: context,
      screen: _findTabToNavigate(index),
      replace: true,
    );
  }

  Widget _findTabToNavigate(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchBySourceScreen();
      case 2:
        return SearchByCategoryScreen();
      case 3:
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }
}
