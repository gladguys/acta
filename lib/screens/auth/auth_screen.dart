import 'package:acta/screens/auth/sign_in_screen.dart';
import 'package:acta/screens/auth/sign_up_screen.dart';
import 'package:acta/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthMode { SIGN_IN, SIGN_UP }

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode authMode;

  @override
  void initState() {
    authMode = AuthMode.SIGN_IN;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  SignInScreen(toggler: toggleScreens);
          } else {
            if (snapshot.hasData) {
              return HomeScreen();
            }
            return SignInScreen(toggler: toggleScreens);
          }
        }
    );
    /*return authMode == AuthMode.SIGN_IN
        ? SignInScreen(toggler: toggleScreens)
        : SignUpScreen(toggler: toggleScreens);*/
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
