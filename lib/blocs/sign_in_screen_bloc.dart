import 'package:acta/models/user.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreenBloc extends BlocBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> signInUser(String email, String password) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = getUserFromAuthResult(authResult);
      storeUserInfo(user);

      return {
        'hasError': false,
        'user': user
      };
    } catch (e) {
      return {
        'hasError': true,
        'code': e.code
      };
    }
  }

  User getUserFromAuthResult(AuthResult authResult) {
    final user = User();
    user.id = authResult.user.uid;
    user.email = authResult.user.email;
    return user;
  }

  Future<void> storeUserInfo(User user) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token-expire', DateTime.now().add(Duration(days: 7)).toIso8601String());
    await sharedPreferences.setString('user-id', user.id);
    await sharedPreferences.setString('user-email', user.email);
  }

  Future<bool> userHasValidToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final dateString = sharedPreferences.getString('token-expire');
    if (dateString == null) {
      return false;
    }

    final DateTime tokenDate = DateTime.parse(dateString);
    return DateTime.now().isAfter(tokenDate);
  }
}