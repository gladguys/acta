import 'package:acta/models/user.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends BlocBase {

  Future<User> getUserFromStore() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final user = User();
    user.id = sharedPreferences.getString('user-id');
    user.email = sharedPreferences.getString('user-email');
    return user;
  }

  Future<void> logoutUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    await FirebaseAuth.instance.signOut();
  }
}