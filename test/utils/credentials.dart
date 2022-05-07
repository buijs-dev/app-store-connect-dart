import 'dart:io';

import 'package:app_store_connect/connect.dart';

/// Helper for creating a JWT.
/// Locally env variables are not set and a gitignored apple_keys.json file is used.
/// For CI env variables are set.
AppStoreCredentials testingCredentials() {
  final env = Platform.environment;
  final issuerId = env["APP_STORE_CONNECT_ISSUER_ID"];
  final keyId = env["APP_STORE_CONNECT_KEY_IDENTIFIER"];
  final key = env["APP_STORE_CONNECT_PRIVATE_KEY"];

  if(issuerId == null) {
    return AppStoreCredentials.fromFile("apple_keys.json");
  }

  if(keyId == null) {
    return AppStoreCredentials.fromFile("apple_keys.json");
  }

  if(key == null) {
    return AppStoreCredentials.fromFile("apple_keys.json");
  }

  return AppStoreCredentials(
    issuerId: issuerId,
    privateKey: key,
    privateKeyId: keyId,
  );

}