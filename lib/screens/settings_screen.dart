import 'package:acta/blocs/configs_bloc.dart';
import 'package:acta/blocs/user_bloc.dart';
import 'package:acta/enums/view_type.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/i18n/at_messages.dart';
import 'package:acta/screens/at_base_screen.dart';
import 'package:acta/utils/navigation.dart';
import 'package:acta/widgets/at_country_picker.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _userBloc = BlocProvider.getBloc<UserBloc>();
  final _configsBloc = BlocProvider.getBloc<ConfigsBloc>();
  ViewType pickedViewType;

  @override
  void initState() {
    pickedViewType = _configsBloc.currentViewType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: ATLabels.ACTA,
      subtitle: ATLabels.SETTINGS,
      body: _buildBody(context),
      initialTab: 3,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
      child: Column(
        children: <Widget>[
          _buildCountryPickerInfo(),
          SizedBox(height: 8),
          _buildViewTypePicker(),
          Divider(
            height: 40.0,
            color: Colors.brown[200],
          ),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildCountryPickerInfo() {
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

  Widget _buildViewTypePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(ATMessages.CHANGE_VIEW_TYPE + ':'),
        ),
        InkWell(
          onTap: () => _updateViewType(ViewType.list),
          child: Icon(
            Icons.view_agenda,
            color: pickedViewType == ViewType.list ? Colors.green : Colors.grey,
          ),
        ),
        InkWell(
          onTap: () => _updateViewType(ViewType.grid),
          child: Icon(
            Icons.dashboard,
            color: pickedViewType == ViewType.grid ? Colors.green : Colors.grey,
          ),
        ),
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
      onPressed: () => _logoutApp(),
    );
  }

  void _updateViewType(ViewType viewType) {
    _configsBloc.updateViewType(viewType);
    setState(() => pickedViewType = viewType);
  }

  void _logoutApp() {
    _userBloc.logoutUser();
    Navigation.exitAppNavigation(context);
  }
}
