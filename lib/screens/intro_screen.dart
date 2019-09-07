import 'package:acta/blocs/news_bloc.dart';
import 'package:acta/blocs/preferences_bloc.dart';
import 'package:acta/i18n/app_localizations.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/screens/home_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _preferencesBloc = BlocProvider.getBloc<PreferencesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[800],
      body: IntroViewsFlutter(
        _getPages(context),
        onTapDoneButton: () => _showSettingsDialog(context),
        doneText: Text(AppLocalizations.of(context).begin),
        showSkipButton: true,
        skipText: Text(AppLocalizations.of(context).skip),
        pageButtonTextStyles: TextStyle(
          color: Colors.brown[900],
          fontSize: 18.0,
        ),
      ),
    );
  }

  List<PageViewModel> _getPages(BuildContext context) {
    final page0 = createPage(
        withTitle: false,
        image: 'assets/images/news.png',
        text: AppLocalizations.of(context).introMessage);

    final page1 = createPage(
        image: 'assets/images/sources.png',
        title: AppLocalizations.of(context).sources,
        text: AppLocalizations.of(context).introSourcesMessage);

    final page2 = createPage(
        image: 'assets/images/countries.png',
        title: AppLocalizations.of(context).countries,
        text: AppLocalizations.of(context).introCountriesMessage);

    final page3 = createPage(
        image: 'assets/images/categories.png',
        title: AppLocalizations.of(context).categories,
        text: AppLocalizations.of(context).introCategoriesMessage);

    return [page0, page1, page2, page3];
  }

  PageViewModel createPage(
      {bool withTitle = true, String image, String title, String text}) {
    return withTitle
        ? PageViewModel(
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
                    image,
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
                    title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.brown[900],
                  ),
                ),
              ],
            ),
          )
        : PageViewModel(
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
                    image,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.brown[900],
                  ),
                ),
              ],
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
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        key: UniqueKey(),
        backgroundColor: Colors.brown[50],
        title: Text(
          AppLocalizations.of(context).oneLastThing,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.brown[900]),
        ),
        content: _buildCountryPickerInfo(context),
        actions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).begin),
            onPressed: () {
              Navigator.of(context).pop();
              _goToHomeScreen(context);
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
        CountryPicker(
          updateCountryFunc: () => setState(() {
            Navigator.pop(context);
            _showSettingsDialog(context);
          }),
        ),
      ],
    );
  }
}

class CountryIcon extends StatelessWidget {
  CountryIcon(
      {@required this.icon,
      @required this.isoCode,
      @required this.updateCountryFunc,
      this.isSelected = false});

  final String icon;
  final String isoCode;
  final Function updateCountryFunc;
  final bool isSelected;

  final _newsBloc = BlocProvider.getBloc<NewsBloc>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickCountry,
      child: Container(
        margin: const EdgeInsets.only(top: 8.0),
        height: 32.0,
        width: 48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          image: DecorationImage(
            image: AssetImage(icon, package: 'country_icons'),
            fit: BoxFit.cover,
          ),
        ),
        foregroundDecoration: isSelected
            ? BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
            )
            : BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.modulate,
                borderRadius: BorderRadius.circular(4.0),
              ),
      ),
    );
  }

  Future<void> _pickCountry() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('country', isoCode);
    GlobalConfiguration().setValue('country', isoCode);
    _newsBloc.updateCountry();
    updateCountryFunc();
  }
}

class CountryPicker extends StatelessWidget {
  CountryPicker({this.updateCountryFunc});

  final Function updateCountryFunc;

  @override
  Widget build(BuildContext context) {
    final pickedCountry = GlobalConfiguration().getString('country');

    return Wrap(
      spacing: 16.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.center,
      children: <Widget>[
        CountryIcon(
          icon: 'icons/flags/png/br.png',
          isoCode: 'br',
          updateCountryFunc: updateCountryFunc,
          isSelected: pickedCountry == 'br',
        ),
        CountryIcon(
          icon: 'icons/flags/png/us.png',
          isoCode: 'us',
          updateCountryFunc: updateCountryFunc,
          isSelected: pickedCountry == 'us',
        ),
        CountryIcon(
          icon: 'icons/flags/png/gb.png',
          isoCode: 'gb',
          updateCountryFunc: updateCountryFunc,
          isSelected: pickedCountry == 'gb',
        ),
        CountryIcon(
          icon: 'icons/flags/png/it.png',
          isoCode: 'it',
          updateCountryFunc: updateCountryFunc,
          isSelected: pickedCountry == 'it',
        ),
        CountryIcon(
          icon: 'icons/flags/png/fr.png',
          isoCode: 'fr',
          updateCountryFunc: updateCountryFunc,
          isSelected: pickedCountry == 'fr',
        ),
      ],
    );
  }
}
