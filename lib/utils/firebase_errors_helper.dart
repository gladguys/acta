import 'package:acta/i18n/app_localizations.dart';
import 'package:flutter/material.dart';

const ERROR_USER_NOT_FOUND = 'ERROR_USER_NOT_FOUND';
const ERROR_EMAIL_ALREADY_IN_USE = 'ERROR_EMAIL_ALREADY_IN_USE';
const ERROR_INVALID_EMAIL = 'ERROR_INVALID_EMAIL';
const ERROR_WRONG_PASSWORD = 'ERROR_WRONG_PASSWORD';

class FirebaseSignInErrorsHelper {
  static String getMessage(BuildContext context, String error) {
    switch (error) {
      case ERROR_INVALID_EMAIL:
        return AppLocalizations.of(context).invalidEmail;
      case ERROR_USER_NOT_FOUND:
        return AppLocalizations.of(context).userNotFound;
      case ERROR_EMAIL_ALREADY_IN_USE:
        return AppLocalizations.of(context).emailAlreadyUsed;
      case ERROR_WRONG_PASSWORD:
        return AppLocalizations.of(context).wrongPassword;
    }
    return 'Unknow error';
  }
}
