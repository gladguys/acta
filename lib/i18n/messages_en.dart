// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "categories": MessageLookupByLibrary.simpleMessage("Categories"),
        "countries": MessageLookupByLibrary.simpleMessage("Countries"),
        "introMessage": MessageLookupByLibrary.simpleMessage(
            "Find the newest news around the world in this app. The news found here are powered by the News API."),
        "introSourcesMessage": MessageLookupByLibrary.simpleMessage(
            "View the breaking news from different sources around the world in one place."),
        "introCountriesMessage": MessageLookupByLibrary.simpleMessage(
            "And set the country you might want to read news from."),
        "introCategoriesMessage": MessageLookupByLibrary.simpleMessage(
            "View the breaking news from different categories."),
        "oneLastThing": MessageLookupByLibrary.simpleMessage(
            "One last thing before you begin..."),
        "begin": MessageLookupByLibrary.simpleMessage("BEGIN"),
        "skip": MessageLookupByLibrary.simpleMessage("SKIP"),
        "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
        "emailAlreadyUsed":
            MessageLookupByLibrary.simpleMessage("Email already in use"),
        "userNotFound": MessageLookupByLibrary.simpleMessage("User not found"),
        "wrongPassword": MessageLookupByLibrary.simpleMessage("Wrong password"),
        "business": MessageLookupByLibrary.simpleMessage("Business"),
        "category": MessageLookupByLibrary.simpleMessage("Category"),
        "chooseCountry":
            MessageLookupByLibrary.simpleMessage("Choose country of the news"),
        "chooseViewType":
            MessageLookupByLibrary.simpleMessage("Choose news view type"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Create an account"),
        "entertainment": MessageLookupByLibrary.simpleMessage("Entertainment"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("I have an account"),
        "health": MessageLookupByLibrary.simpleMessage("Health"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "registerAccount":
            MessageLookupByLibrary.simpleMessage("Register an account"),
        "science": MessageLookupByLibrary.simpleMessage("Science"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sources": MessageLookupByLibrary.simpleMessage("Sources"),
        "sports": MessageLookupByLibrary.simpleMessage("Sports"),
        "technology": MessageLookupByLibrary.simpleMessage("Technology")
      };
}
