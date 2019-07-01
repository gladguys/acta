import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'at-base-screen.dart';

class HomeScreen extends StatelessWidget {
  Widget _buildHomeScreen() {
    return Center(
      child: Text('My home screen'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(title: 'My HOME screen', body: _buildHomeScreen(), initialTab: 0,);
  }
}
