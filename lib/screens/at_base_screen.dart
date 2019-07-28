import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/bottomNavigation/main_bottom_navigator.dart';

class ATBaseScreen extends StatelessWidget {
  ATBaseScreen({
    @required this.body,
    this.title,
    this.subtitle,
    this.actions,
    this.initialTab = 0,
  });

  final String title;
  final String subtitle;
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
        title ?? 'Acta',
        style: TextStyle(
          fontFamily: 'Italianno',
          fontSize: 52.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: subtitle != null
          ? PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 28),
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(0, 0),
              child: Container(),
            ),
      actions: actions,
    );
  }
}
