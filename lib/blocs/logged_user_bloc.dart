import 'package:acta/models/user.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';

class LoggedUserBloc extends BlocBase {

  final BehaviorSubject<User> _loggedUserController = BehaviorSubject<User>.seeded(null);

  User get getLoggedUser => _loggedUserController.value;

  void setLoggedUser(User user) {
    _loggedUserController.add(user);
  }

  @override
  void dispose() {
    _loggedUserController.close();
    super.dispose();
  }
}