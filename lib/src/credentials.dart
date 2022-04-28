// Copyright (c) 2021 - 2022 Buijs Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'dart:convert';
import 'package:jose/jose.dart';
import 'package:path/path.dart';

import 'exception.dart';
import 'utils/files.dart';

/// Utility to create a JWT token and HTTP client for connecting to app-store-connect-api.
///
/// An [AppleCredentials] instance can be created either
/// directly by using the primary constructor
/// or by deserializing a JSON file (recommended).
///
/// Example valid JSON file:
///
/// ```
/// {
///   "private_key_id": "1ABC2D3E46",
///   "private_key": "-----BEGIN PRIVATE KEY-----\nCONTENT\n-----END PRIVATE KEY-----",
///   "issuer_id": "1a23bc45-67de-8f90-gh1i-j2k3lmn4o56p"
/// }
/// ```
///
/// [Author] Gillian Buijs.
class AppleCredentials {
  const AppleCredentials({
    required this.privateKeyId,
    required this.privateKey,
    required this.issuerId,
  });

  /// The private key ID from App Store Connect.
  final String privateKeyId;

  /// The private key file (content) from App Store Connect.
  final String privateKey;

  /// The issuer ID from the API keys page in App Store Connect.
  final String issuerId;

  /// Create an [AppleCredentials] instance by deserializing a file from the given path.
  ///
  /// Path can be a String [path] absolute path or a File instance.
  ///
  /// Throws [AppStoreConnectException] if the [path] does not exist
  /// or if the file extension is not '.json'.
  ///
  /// Return [AppleCredentials] used to create a JWT token and connect to app-store-connect-api.
  factory AppleCredentials.fromFile(dynamic path) {
    final source = FileFactory(path).file();
    if(extension(source.path) != "json") {
      throw AppStoreConnectException(
          """|Could not create an AppleCredentials instance because the given path is not a JSON file.
             |
             |Path: '${source.absolute.path}'
          """
      );

    }
    return AppleCredentials.fromJson(source.readAsStringSync());
  }

  /// Deserialize JSON string to an [AppleCredentials] instance.
  ///
  /// Throws [AppStoreConnectException] if the JSON is not valid.
  ///
  /// Return [AppleCredentials] used to create a JWT token and connect to app-store-connect-api.
  factory AppleCredentials.fromJson(String fileContent) {
    final json = jsonDecode(fileContent);
    return AppleCredentials(
      privateKeyId: _propertyOrFail(json, "private_key_id"),
      privateKey: _propertyOrFail(json, "private_key"),
      issuerId: _propertyOrFail(json, "issuer_id"),
    );
  }

  /// Create a JSON web token with the given key information.
  String get jsonWebToken {
    final expirationDate = DateTime.now().add(const Duration(minutes: 15));

    final payload = <String, dynamic>{
      'iss': issuerId,
      'exp': expirationDate.millisecondsSinceEpoch ~/ 1000,
      'aud': 'appstoreconnect-v1'
    };

    var builder = JsonWebSignatureBuilder()
      ..jsonContent = JsonWebTokenClaims.fromJson(payload).toJson()
      ..addRecipient(
        JsonWebKey.fromPem(
          privateKey,
          keyId: privateKeyId,
        ),
        algorithm: 'ES256',
      );

    return builder.build().toCompactSerialization();
  }

  ///Get a property by name or throw [AppStoreConnectException] if not found.
  static String _propertyOrFail(dynamic json, String key) {
    final type = json[key];

    if (type == null) {
      throw AppStoreConnectException("Missing key named '$key' in JSON document.");
    }

    return type;
  }

}