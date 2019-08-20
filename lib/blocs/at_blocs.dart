import 'package:acta/blocs/logged_user_bloc.dart';
import 'package:acta/blocs/news_bloc.dart';
import 'package:acta/blocs/sign_in_screen_bloc.dart';
import 'package:acta/blocs/sign_up_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

final atBlocs = [
  Bloc((i) => SignInScreenBloc()),
  Bloc((i) => SignUpScreenBloc()),
  Bloc((i) => LoggedUserBloc()),
  Bloc((i) => NewsBloc()),
];