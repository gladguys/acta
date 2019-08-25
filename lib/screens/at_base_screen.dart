import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/bottomNavigation/main_bottom_navigator.dart';

class ATBaseScreen extends StatelessWidget {
  ATBaseScreen({
    @required this.title,
    @required this.body,
    this.subtitle,
    this.actions,
    this.initialTab = 0,
    this.withbBottomNavigationBar = true,
  });

  final String title;
  final String subtitle;
  final Widget body;
  final List<Widget> actions;
  final int initialTab;
  final bool withbBottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: subtitle == null
          ? _buildAppBar(context)
          : _buildAppBarWithSubtitle(context),
      body: body,
      bottomNavigationBar: withbBottomNavigationBar
          ? MainBottomNavigator(
              initialIndex: initialTab,
            )
          : null,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: _buildAppBarTitle(context),
      actions: actions,
    );
  }

  Widget _buildAppBarWithSubtitle(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: _buildAppBarTitle(context),
      bottom: PreferredSize(
        preferredSize: Size(100.0, 20.0),
        child: Text(
          subtitle,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown[400],
          ),
        ),
      ),
      actions: actions,
    );
  }

  Widget _buildAppBarTitle(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Italianno',
        fontSize: 56.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
