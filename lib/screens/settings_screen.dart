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
      subtitle: ATLabels.SETTINGS,
      body: _buildBody(context),
      withbBottomNavigationBar: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
      child: Column(
        children: <Widget>[
          _buildCountryPickerInfo(context),
          Divider(
            height: 40.0,
            color: Colors.brown[200],
          ),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildCountryPickerInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(ATMessages.CHANGE_COUNTRY_NEWS + ':'),
        ),
        ATCountryPicker(),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return RaisedButton.icon(
      color: Colors.brown[700],
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      icon: Icon(Icons.exit_to_app),
      label: Text(ATLabels.LOGOUT),
      onPressed: () => _logoutApp(context),
    );
  }

  void _logoutApp(BuildContext context) {
    _userBloc.logoutUser();
    Navigation.exitAppNavigation(context);
  }
}
