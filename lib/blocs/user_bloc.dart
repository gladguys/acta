import 'package:acta/models/user.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';

class UserBloc extends BlocBase {

  final BehaviorSubject<User> _loggedUserController = BehaviorSubject<User>.seeded(null);

  User get getLoggedUser => _loggedUserController.value;

  void setLoggedUser(User user) {
    _loggedUserController.add(user);
  }

  Future<void> logoutUser() async {
    _loggedUserController.add(null);
    await FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    _loggedUserController.close();
    super.dispose();
  }
}