import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigsBloc extends BlocBase {
  static Map<String, dynamic> currentValues;

  Future<void> initConfigs() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    currentValues = <String, dynamic>{
      'isFirstLoginDone': sharedPreferences.getBool('isFirstLoginDone') ?? false
    };
  }

  static bool get isFirstLoginDone => currentValues['isFirstLoginDone'];
}