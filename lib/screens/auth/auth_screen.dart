import 'package:acta/blocs/configs_bloc.dart';
import 'package:acta/screens/auth/sign_in_screen.dart';
import 'package:acta/screens/auth/sign_up_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

enum AuthMode { SIGN_IN, SIGN_UP }

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _configsBloc = BlocProvider.getBloc<ConfigsBloc>();
  AuthMode authMode;

  @override
  void initState() {
    authMode = AuthMode.SIGN_IN;
    _configsBloc.initConfigs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return authMode == AuthMode.SIGN_IN
        ? SignInScreen(toggler: toggleScreens)
        : SignUpScreen(toggler: toggleScreens);
  }

  void toggleScreens() {
    setState(() {
      if (authMode == AuthMode.SIGN_IN) {
        authMode = AuthMode.SIGN_UP;
      } else {
        authMode = AuthMode.SIGN_IN;
      }
    });
  }
}
