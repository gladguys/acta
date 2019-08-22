import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesBloc extends BlocBase {

  Future<void> setIsFirstLoginDone() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isFirstLoginDone', true);
  }
}