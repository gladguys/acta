import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:acta/widgets/at_country_picker.dart';
import '../widgets/bottomNavigation/main_bottom_navigator.dart';

class ATBaseScreen extends StatelessWidget {
  ATBaseScreen({
    @required this.title,
    @required this.body,
    this.actions,
    this.initialTab = 0,
  });

  final String title;
  final Widget body;
  final List<Widget> actions;
  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: _buildAppBar(context),
      body: body,
      bottomNavigationBar: MainBottomNavigator(
        initialIndex: initialTab,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Italianno',
          fontSize: 44.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }
}
