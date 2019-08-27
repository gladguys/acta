import 'package:acta/blocs/news_bloc.dart';
import 'package:acta/utils/supported_countries.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ATCountryPicker extends StatelessWidget {
  final _bloc = BlocProvider.getBloc<NewsBloc>();

  @override
  Widget build(BuildContext context) {
    return CountryPickerDropdown(
      itemFilter: _filterCountry,
      initialValue: GlobalConfiguration().get('country'),
      itemBuilder: _buildDropdownItem,
      onValuePicked: (Country country) => _updateCountry(context, country),
    );
  }

  Future<void> _updateCountry(BuildContext context, Country country) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String countryCode = country.isoCode.toLowerCase();
    await sharedPreferences.setString('country', countryCode);
    GlobalConfiguration().setValue('country', countryCode);
    _bloc.updateCountry();
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
