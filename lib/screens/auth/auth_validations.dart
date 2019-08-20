class AuthValidations {
  static String emailValidator(String email) {
    if (email.isEmpty) {
      return 'Required field';
    }
    const Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return 'Enter Valid Email';
    }
    return null;
  }

  static String emailsMatchValidator(String email, String confirmationEmail) {
    return email != confirmationEmail ? 'The emails don\'t match' : null;
  }

  static String passwordValidator(String password) {
    if (password.isEmpty) {
      return 'Required field';
    }
    return password.length < 6 ? 'The minimum lenght is 6' : null;
  }
}
