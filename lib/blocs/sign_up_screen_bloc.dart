import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreenBloc extends BlocBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> createUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return {'hasError': false};
    } catch (e) {
      return {'hasError': true, 'code': e.code};
    }
  }
}
