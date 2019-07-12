import 'package:acta/widgets/at_country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/bottomNavigation/main_bottom_navigator.dart';

class ATBaseScreen extends StatelessWidget {
  ATBaseScreen(
      {@required this.title,
      @required this.body,
      this.actions,
      this.initialTab = 0});

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
      title: _buildAppBarTitle(context),
      centerTitle: true,
      elevation: 0,
      actions: actions,
    );
  }

  Widget _buildAppBarTitle(BuildContext context) {
    return Container(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ATCountryPicker(),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Italianno',
                fontSize: 36.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
