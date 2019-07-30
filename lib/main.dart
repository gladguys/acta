import 'package:acta/theme/at_theme.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'blocs/news_bloc.dart';

void main() => _loadApp();

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

class MainApp extends StatelessWidget {
  final page = PageViewModel(
    pageColor: const Color(0xFF607D8B),
    iconImageAssetPath: 'assets/images/arena.jpeg',
    iconColor: null,
    bubbleBackgroundColor: Color(100),
    body: Text(
      'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
    ),
    title: Text('Cabs'),
    mainImage: Image.asset(
      'assets/taxi.png',
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
    textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acta',
      debugShowCheckedModeBanner: false,
      navigatorKey: Catcher.navigatorKey,
      theme: atTheme,
      home: IntroViewsFlutter(
        [page],
        onTapDoneButton: (){
          //Void Callback
        },
        showSkipButton: true,
        pageButtonTextStyles: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: 'Regular',
        ),
      ),
    );
  }
}