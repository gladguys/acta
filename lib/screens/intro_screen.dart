import 'package:acta/blocs/preferences_bloc.dart';
import 'package:acta/i18n/app_localizations.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/screens/home_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/widgets/at_country_picker.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

final page0 = PageViewModel(
  pageColor: Colors.brown[100],
  bubbleBackgroundColor: Colors.brown[700],
  textStyle: TextStyle(color: Colors.brown[900]),
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
          color: Colors.brown[900],
        ),
      ),
      Expanded(
        child: Image.asset(
          'assets/images/news.png',
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    ],
  ),
  body: Column(
    children: <Widget>[
      Text(
        'As mais recentes notícias do mundo em um só app. Nossa fonte de notícias é o News API.',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.brown[900],
        ),
      ),
    ],
  ),
);

final page = PageViewModel(
  pageColor: Colors.brown[100],
  bubbleBackgroundColor: Colors.brown[700],
  textStyle: TextStyle(color: Colors.brown[900]),
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
          color: Colors.brown[900],
        ),
      ),
      Expanded(
        child: Image.asset(
          'assets/images/sources.png',
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    ],
  ),
  body: Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          'Sources',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown[900],
          ),
        ),
      ),
      Text(
        'View the breaking news from different sources around the world in one place.',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.brown[900],
        ),
      ),
    ],
  ),
);

final page2 = PageViewModel(
  pageColor: Colors.brown[100],
  bubbleBackgroundColor: Colors.brown[700],
  textStyle: TextStyle(color: Colors.brown[900]),
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
          color: Colors.brown[900],
        ),
      ),
      Expanded(
        child: Image.asset(
          'assets/images/countries.png',
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    ],
  ),
  body: Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          'Countries',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown[900],
          ),
        ),
      ),
      Text(
        'And set the country you might want to read news from.',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.brown[900],
        ),
      ),
    ],
  ),
);

final page3 = PageViewModel(
  pageColor: Colors.brown[100],
  bubbleBackgroundColor: Colors.brown[700],
  textStyle: TextStyle(color: Colors.brown[900]),
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
          color: Colors.brown[900],
        ),
      ),
      Expanded(
        child: Image.asset(
          'assets/images/categories.png',
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    ],
  ),
  body: Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          'Categories',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown[900],
          ),
        ),
      ),
      Text(
        'View the breaking news from different categories!',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.brown[900],
        ),
      ),
    ],
  ),
);

class IntroScreen extends StatelessWidget {
  final _preferencesBloc = BlocProvider.getBloc<PreferencesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[800],
      body: IntroViewsFlutter(
        [page0, page, page2, page3],
        onTapDoneButton: () => _goToHomeScreen(context),
        showSkipButton: true,
        pageButtonTextStyles: TextStyle(
          color: Colors.brown[900],
          fontSize: 18.0,
        ),
      ),
    );
  }

  void _goToHomeScreen(BuildContext context) {
    _preferencesBloc.setIsFirstLoginDone();
    Navigation.navigateFromInside(
      context: context,
      screen: HomeScreen(),
      replace: true,
    );
    _showSettingsDialog(context);
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.brown[50],
        title: Text(
          'Basic settings',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.brown[900]),
        ),
        content: _buildCountryPickerInfo(context),
        actions: <Widget>[
          FlatButton(
            child: Text('DONE'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCountryPickerInfo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).chooseCountry + ':',
          style: TextStyle(
            color: Colors.brown[700],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown[700]),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: ATCountryPicker(),
            ),
          ],
        ),
      ],
    );
  }
}
