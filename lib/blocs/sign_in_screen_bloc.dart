import 'package:acta/models/user.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreenBloc extends BlocBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> signInUser(String email, String password) async {

    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

        return {
          'hasError': false,
          'user': User(id: authResult.user.uid, email: authResult.user.email)
        };
    } catch (e) {
      return {
        'hasError': true,
        'code': e.code
      };
    }
  }
}