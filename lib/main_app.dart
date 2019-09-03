import 'package:acta/i18n/app_localizations.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/screens/auth/auth_screen.dart';
import 'package:acta/screens/home_screen.dart';
import 'package:acta/theme/at_theme.dart';
import 'package:acta/widgets/at_waiting.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _userHasValidToken(),
      builder: (_, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            title: ATLabels.ACTA,
            localizationsDelegates: [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('pt'),
              const Locale('fr'),
              const Locale('it'),
            ],
            navigatorKey: Catcher.navigatorKey,
            theme: atTheme,
            home: snapshot.data ? HomeScreen() : AuthScreen(),
          );
        }
        return ATWaiting();
      },
    );
  }

  Future<bool> _userHasValidToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final dateString = sharedPreferences.getString('token-expire');
    if (dateString == null) {
      return false;
    }

    final DateTime tokenDate = DateTime.parse(dateString);
    return DateTime.now().isBefore(tokenDate);
  }
}
