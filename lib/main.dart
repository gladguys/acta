import 'package:acta/blocs/at_blocs.dart';
import 'package:acta/i18n/at_labels.dart';
import 'package:acta/main_app.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => _loadApp();

Future<void> _loadApp() async {
  await _loadConfig();

  final CatcherOptions debugOptions = CatcherOptions(DialogReportMode(), [
    EmailAutoHandler(
      'smtp.gmail.com',
      587,
      'actaflutter@gmail.com',
      ATLabels.ACTA_CATCHER,
      'acta1234',
      ['actaflutter@gmail.com'],
    )
  ]);

  final CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler(
      ['recipient@email.com'],
    )
  ]);

  Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

Future<void> _loadConfig() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  await GlobalConfiguration().loadFromAsset('app_settings')
    ..setValue('country', sharedPreferences.get('country') ?? 'us')
    ..setValue('viewType', sharedPreferences.get('viewType') ?? '0');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: atBlocs,
      child: MainApp(),
    );
  }
}
