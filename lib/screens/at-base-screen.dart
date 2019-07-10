import 'package:acta/blocs/news_bloc.dart';
import 'package:acta/providers/news_provider.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';

import 'package:global_configuration/global_configuration.dart';
import 'package:acta/utils/supported_countries.dart';
import '../widgets/bottomNavigation/main-bottom-navigator.dart';

class ATBaseScreen extends StatelessWidget {
  ATBaseScreen(
      {@required this.title,
      @required this.body,
      this.actions,
      this.initialTab = 0});

  final NewsBloc bloc = BlocProvider.getBloc<NewsBloc>();

  final String title;
  final Widget body;
  final List<Widget> actions;
  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        leading: _buildCountryPicker(context),
        title: Text(
          title,
          style: TextStyle(
              fontFamily: 'Italianno',
              fontSize: 36.0,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: MainBottomNavigator(
        initialIndex: initialTab,
      ),
    );
  }

  Widget _buildCountryPicker(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2.0),
      child: CountryPickerDropdown(
          itemFilter: _filterCountry,
          initialValue: GlobalConfiguration().get('country'),
          itemBuilder: _buildDropdownItem,
          onValuePicked: (Country country) => _updateCountry(context, country)),
    );
  }

  Future<void> _updateCountry(BuildContext context, Country country) async {
    GlobalConfiguration().setValue('country', country.isoCode.toLowerCase());
    bloc.updateCountry();
  }

  bool _filterCountry(Country country) {
    return supportedCountries.any((c) => c.toUpperCase() == country.isoCode);
  }

  Widget _buildDropdownItem(Country country) {
    return Container(
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
        ],
      ),
    );
  }
}
