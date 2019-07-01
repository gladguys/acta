import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acta/widgets/drawer/at-drawer.dart';

class ATBaseScreen extends StatelessWidget {
  final String title;
  final Widget body;

  ATBaseScreen({@required this.title, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: ATDrawer(),
      body: body
    );
  }
}