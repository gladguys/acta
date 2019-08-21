import 'package:acta/blocs/configs_bloc.dart';
import 'package:acta/blocs/user_bloc.dart';
import 'package:acta/blocs/news_bloc.dart';
import 'package:acta/blocs/preferences_bloc.dart';
import 'package:acta/blocs/sign_in_screen_bloc.dart';
import 'package:acta/blocs/sign_up_screen_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

final atBlocs = [
  Bloc((i) => SignInScreenBloc()),
  Bloc((i) => SignUpScreenBloc()),
  Bloc((i) => UserBloc()),
  Bloc((i) => PreferencesBloc()),
  Bloc((i) => ConfigsBloc()),
  Bloc((i) => NewsBloc()),
];