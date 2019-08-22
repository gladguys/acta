import 'package:acta/blocs/user_bloc.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/i18n/at_messages.dart';
import 'package:acta/screens/at_base_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/widgets/at_country_picker.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final _userBloc = BlocProvider.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: ATLabels.ACTA,
      body: Column(
        children: <Widget>[
          _buildCountryPickerInfo(context),
        ],
      ),
      withbBottomNavigationBar: false,
    );
  }

  Widget _buildCountryPickerInfo(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(ATMessages.CHANGE_COUNTRY_NEWS),
                ATCountryPicker(),
              ],
            ),
            _buildLogoutButton(context),
          ],
        ));
  }

  Widget _buildLogoutButton(BuildContext context) {
    return RaisedButton(
      child: Text(ATLabels.LOGOUT),
      onPressed: () => _logoutApp(context),
    );
  }

  void _logoutApp(BuildContext context) {
    _userBloc.logoutUser();
    Navigation.exitAppNavigation(context);
  }
}
