import 'package:flutter/material.dart';

import './screens/home-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.brown[100],
        accentColor: Colors.brown[800],
      ),
      home: HomeScreen(),
    );
  }
}
