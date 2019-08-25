import 'package:acta/blocs/preferences_bloc.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/screens/home_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

final page = PageViewModel(
  pageColor: Colors.brown[900],
  bubbleBackgroundColor: Colors.brown[200],
  textStyle: TextStyle(color: Colors.brown[50]),
  iconColor: null,
  title: Container(),
  mainImage: Column(
    children: <Widget>[
      Text(
        ATLabels.ACTA,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Italianno',
          fontSize: 64.0,
          fontWeight: FontWeight.bold,
          color: Colors.brown[50],
        ),
      ),
      Image.asset(
        'assets/images/taxi.png',
        height: 250.0,
        width: 250.0,
        alignment: Alignment.center,
      ),
    ],
  ),
  body: Text(
    'Easy cab booking at your doorstep with cashless payment system',
  ),
  iconImageAssetPath: 'assets/images/taxi.png',
);

final page2 = PageViewModel(
  pageColor: Colors.brown[700],
  bubbleBackgroundColor: Colors.brown[200],
  textStyle: TextStyle(color: Colors.brown[50]),
  iconColor: null,
  title: Container(),
  mainImage: Column(
    children: <Widget>[
      Text(
        ATLabels.ACTA,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Italianno',
          fontSize: 64.0,
          fontWeight: FontWeight.bold,
          color: Colors.brown[50],
        ),
      ),
      Image.asset(
        'assets/images/taxi.png',
        height: 250.0,
        width: 250.0,
        alignment: Alignment.center,
      ),
    ],
  ),
  body: Text(
    'Easy cab booking at your doorstep with cashless payment system',
  ),
  iconImageAssetPath: 'assets/images/taxi-driver.png',
);

final page3 = PageViewModel(
  pageColor: Colors.brown[500],
  bubbleBackgroundColor: Colors.brown[200],
  textStyle: TextStyle(color: Colors.brown[50]),
  iconColor: null,
  title: Container(),
  mainImage: Column(
    children: <Widget>[
      Text(
        ATLabels.ACTA,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Italianno',
          fontSize: 64.0,
          fontWeight: FontWeight.bold,
          color: Colors.brown[50],
        ),
      ),
      Image.asset(
        'assets/images/taxi.png',
        height: 250.0,
        width: 250.0,
        alignment: Alignment.center,
      ),
    ],
  ),
  body: Text(
    'Easy cab booking at your doorstep with cashless payment system',
  ),
  iconImageAssetPath: 'assets/images/taxi-driver.png',
);

class IntroScreen extends StatelessWidget {
  final _preferencesBloc = BlocProvider.getBloc<PreferencesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[800],
      body: IntroViewsFlutter(
        [page, page2, page3],
        onTapDoneButton: () => _goToHomeScreen(context),
        showSkipButton: true,
        pageButtonTextStyles: TextStyle(
          color: Colors.brown[50],
          fontSize: 18.0,
        ),
      ),
    );
  }

  void _goToHomeScreen(BuildContext context) {
    _preferencesBloc.setIsFirstLoginDone();
    Navigation.navigateFromInside(
        context: context, screen: HomeScreen(), replace: true);
  }
}
