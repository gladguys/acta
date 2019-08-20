const ERROR_USER_NOT_FOUND = 'ERROR_USER_NOT_FOUND';
const ERROR_EMAIL_ALREADY_IN_USE = 'ERROR_EMAIL_ALREADY_IN_USE';
const ERROR_INVALID_EMAIL = 'ERROR_INVALID_EMAIL';
const ERROR_WRONG_PASSWORD = 'ERROR_WRONG_PASSWORD';

class FirebaseSignInErrorsHelper {
  static String getMessage(String error) {
    switch (error) {
      case ERROR_INVALID_EMAIL:
        return 'Invalid email';
      case ERROR_USER_NOT_FOUND:
        return 'User not found';
      case ERROR_EMAIL_ALREADY_IN_USE:
        return 'Email already in use';
      case ERROR_WRONG_PASSWORD:
        return 'Wrong password';
    }
    return 'Unknow error';
  }
}