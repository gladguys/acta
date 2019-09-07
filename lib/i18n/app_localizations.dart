import 'dart:async';

import 'package:acta/i18n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get introMessage {
    return Intl.message(
      'Find the newest news around the world in this app. The news found here are powered by the News API.',
      name: 'introMessage',
      desc: 'Intro message',
    );
  }

  String get introSourcesMessage {
    return Intl.message(
      'View the breaking news from different sources around the world in one place.',
      name: 'introSourcesMessage',
      desc: 'Intro sources email message',
    );
  }

  String get introCountriesMessage {
    return Intl.message(
      'And set the country you might want to read news from.',
      name: 'introCountriesMessage',
      desc: 'Intro countries message',
    );
  }

  String get introCategoriesMessage {
    return Intl.message(
      'View the breaking news from different categories.',
      name: 'introCategoriesMessage',
      desc: 'Intro categories message',
    );
  }

  String get oneLastThing {
    return Intl.message(
      'One last thing before you begin...',
      name: 'oneLastThing',
      desc: 'One last thing message',
    );
  }

  String get begin {
    return Intl.message(
      'BEGIN',
      name: 'begin',
      desc: 'Begin message',
    );
  }

  String get skip {
    return Intl.message(
      'SKIP',
      name: 'skip',
      desc: 'Skip message',
    );
  }

  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: 'Invalid email message',
    );
  }

  String get emailAlreadyUsed {
    return Intl.message(
      'Email already in use',
      name: 'emailAlreadyUsed',
      desc: 'Email in use message',
    );
  }

  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: 'User not found email message',
    );
  }

  String get wrongPassword {
    return Intl.message(
      'Wrong password',
      name: 'wrongPassword',
      desc: 'Wrong password message',
    );
  }

  String get sources {
    return Intl.message(
      'Sources',
      name: 'sources',
      desc: 'The sources of the news',
    );
  }

  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: 'The category of the news',
    );
  }

  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: 'The categories',
    );
  }

  String get countries {
    return Intl.message(
      'Countries',
      name: 'countries',
      desc: 'The countries',
    );
  }

  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'The settings of the app',
    );
  }

  String get chooseCountry {
    return Intl.message(
      'Choose country of the news',
      name: 'chooseCountry',
      desc: 'The message to choose the country of the news',
    );
  }

  String get chooseViewType {
    return Intl.message(
      'Choose news view type',
      name: 'chooseViewType',
      desc: 'The message to choose between the view types',
    );
  }

  String get createAccount {
    return Intl.message(
      'Create an account',
      name: 'createAccount',
      desc: 'Create an account label',
    );
  }

  String get registerAccount {
    return Intl.message(
      'Register an account',
      name: 'registerAccount',
      desc: 'Register an account label',
    );
  }

  String get haveAccount {
    return Intl.message(
      'I have an account',
      name: 'haveAccount',
      desc: 'I have an account label',
    );
  }

  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: 'Create label',
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Password label',
    );
  }

  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'Logout label',
    );
  }

  String get business {
    return Intl.message(
      'Business',
      name: 'business',
      desc: 'Business label',
    );
  }

  String get entertainment {
    return Intl.message(
      'Entertainment',
      name: 'entertainment',
      desc: 'Entertainment label',
    );
  }

  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: 'General label',
    );
  }

  String get health {
    return Intl.message(
      'Health',
      name: 'health',
      desc: 'Health label',
    );
  }

  String get science {
    return Intl.message(
      'Science',
      name: 'science',
      desc: 'Science label',
    );
  }

  String get sports {
    return Intl.message(
      'Sports',
      name: 'sports',
      desc: 'Sports label',
    );
  }

  String get technology {
    return Intl.message(
      'Technology',
      name: 'technology',
      desc: 'Technology label',
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr', 'pt', 'it'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
