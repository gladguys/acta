import 'package:acta/screens/home_screen.dart';
import 'package:acta/theme/at_theme.dart';
import 'package:flutter/material.dart';
import 'package:catcher/catcher_plugin.dart';

class MainApp extends Widget {
  @override
  Element createElement() {
    return MaterialApp(
      title: 'Acta',
      navigatorKey: Catcher.navigatorKey,
      theme: atTheme,
      home: HomeScreen(),
    ).createElement();
  }
}
