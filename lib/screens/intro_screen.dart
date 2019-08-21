import 'package:acta/blocs/preferences_bloc.dart';
import 'package:acta/screens/home_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

final page = PageViewModel(
  pageColor: const Color(0xFF607D8B),
  iconImageAssetPath: 'assets/images/taxi.png',
  iconColor: null,
  bubbleBackgroundColor: Colors.amberAccent,
  body: Text(
    'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
  ),
  title: Text('Cabs'),
  mainImage: Image.asset(
    'assets/images/taxi.png',
    height: 285.0,
    width: 285.0,
    alignment: Alignment.center,
  ),
  textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
);

final page2 = PageViewModel(
  pageColor: const Color(0xFF607D8B),
  iconImageAssetPath: 'assets/images/taxi-driver.png',
  iconColor: null,
  bubbleBackgroundColor: Colors.amberAccent,
  body: Text(
    'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
  ),
  title: Text('Cabs'),
  mainImage: Image.asset(
    'assets/images/taxi.png',
    height: 285.0,
    width: 285.0,
    alignment: Alignment.center,
  ),
  textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
);

final page3 = PageViewModel(
  pageColor: const Color(0xFF607D8B),
  iconImageAssetPath: 'assets/images/hotel.png',
  iconColor: null,
  bubbleBackgroundColor: Colors.amberAccent,
  body: Text(
    'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
  ),
  title: Text('Cabs'),
  mainImage: Image.asset(
    'assets/images/taxi.png',
    height: 285.0,
    width: 285.0,
    alignment: Alignment.center,
  ),
  textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
);

class IntroScreen extends StatelessWidget {

  final _preferencesBloc = BlocProvider.getBloc<PreferencesBloc>();

  @override
  Widget build(BuildContext context) {
    print('yeyeeee');
    return Scaffold(
      body: IntroViewsFlutter(
        [page, page2, page3],
        onTapDoneButton: () => _goToHomeScreen(context),
        showSkipButton: true,
        pageButtonTextStyles: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: 'Regular',
        ),
      ),
    );
  }

  void _goToHomeScreen(BuildContext context) {
    _preferencesBloc.setIsFirstLoginDone();
    Navigation.navigateFromInside(context: context, screen: HomeScreen());
  }
}