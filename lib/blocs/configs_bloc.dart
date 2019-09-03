import 'package:acta/enums/view_type.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigsBloc extends BlocBase {
  static Map<String, dynamic> currentValues;

  Future<void> initConfigs() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    currentValues = <String, dynamic>{
      'isFirstLoginDone': sharedPreferences.getBool('isFirstLoginDone') ?? false
    };
  }

  static bool get isFirstLoginDone => currentValues['isFirstLoginDone'];

  ViewType get currentViewType => GlobalConfiguration().getInt('viewType') == 0
      ? ViewType.grid
      : ViewType.list;

  Future<void> updateViewType(ViewType viewType) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setInt('viewType', viewType.index);
    GlobalConfiguration().setValue('viewType', viewType.index);
  }
}
