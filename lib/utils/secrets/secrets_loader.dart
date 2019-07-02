import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:acta/utils/secrets/secret.dart';
import 'package:flutter/services.dart' show rootBundle;

class SecretLoader {
  SecretLoader({this.secretPath});

  final String secretPath;

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(secretPath, (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
