import 'package:acta/main_app.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:catcher/catcher_plugin.dart';

import 'blocs/news_bloc.dart';

void main() {
  _loadApp();
}

Future<void> _loadApp() async {
  await _loadConfig();

  final CatcherOptions debugOptions = CatcherOptions(DialogReportMode(), [
    EmailAutoHandler('smtp.gmail.com', 587, 'actaflutter@gmail.com',
        'AcTa Catcher', 'acta1234', ['rodrigobastosv@gmail.com'])
  ]);

  final CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler(['recipient@email.com'])
  ]);

  Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

Future<void> _loadConfig() async {
  await GlobalConfiguration().loadFromAsset('app_settings');
  GlobalConfiguration().setValue('country', 'us');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MainApp(),
      blocs: [
        Bloc((i) => NewsBloc()),
      ],
    );
  }
}
