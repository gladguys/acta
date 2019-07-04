import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import './screens/home-screen.dart';

void main() {
  _loadApp();
}

Future<void> _loadApp() async {
  await _loadConfig();
  runApp(MyApp());
}

Future<void> _loadConfig() async {
  await GlobalConfiguration().loadFromAsset('app_settings');
}

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
