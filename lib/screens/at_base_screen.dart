import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:acta/widgets/at_country_picker.dart';
import '../widgets/bottomNavigation/main_bottom_navigator.dart';

class ATBaseScreen extends StatelessWidget {
  ATBaseScreen(
      {@required this.title,
      @required this.body,
      this.actions,
      this.initialTab = 0,
      this.withCountryPicker = true});

  final String title;
  final Widget body;
  final List<Widget> actions;
  final int initialTab;
  final bool withCountryPicker;

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
      centerTitle: !withCountryPicker,
      title: withCountryPicker 
        ? _buildAppBarTitle(context)
        : _buildAppBarTitleSimple(context),
      actions: actions,
    );
  }

  Widget _buildAppBarTitle(BuildContext context) {
    return Row(
      children: <Widget>[
        ATCountryPicker(),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Italianno',
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarTitleSimple(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Italianno',
        fontSize: 44.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
