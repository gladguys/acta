class User {

  User({this.id, this.email});

  String id;
  String email;

  @override
  String toString() {
    return 'User{id: $id, email: $email}';
  }
}