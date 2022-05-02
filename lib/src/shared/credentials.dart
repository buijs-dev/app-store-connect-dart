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

import 'package:crypto_keys/crypto_keys.dart' as crypto;
import 'package:x509/x509.dart' as x509;

import '../../appstoreconnect.dart';
import '../utils/library.dart';

/// Utility to create a JWT token and HTTP client for connecting to app-store-connect-api.
///
/// An [AppStoreCredentials] instance can be created either
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
class AppStoreCredentials {
  const AppStoreCredentials({
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

  /// Create an [AppStoreCredentials] instance by deserializing a file from the given path.
  ///
  /// Path can be a String [path] absolute path or a File instance.
  ///
  /// Throws [AppStoreConnectException] if the [path] does not exist
  /// or if the file extension is not '.json'.
  ///
  /// Return [AppStoreCredentials] used to create a JWT token and connect to app-store-connect-api.
  factory AppStoreCredentials.fromFile(dynamic path) {
    final source = FileFactory(path).file();
    if (!source.path.endsWith(".json")) {
      throw AppStoreCredentialsException(
          """|Could not create an AppleCredentials instance because the given path is not a JSON file.
             |
             |Path: '${source.absolute.path}'
          """);
    }
    return AppStoreCredentials.fromJson(source.readAsStringSync());
  }

  /// Deserialize JSON string to an [AppStoreCredentials] instance.
  ///
  /// Throws [AppStoreConnectException] if the JSON is not valid.
  ///
  /// Return [AppStoreCredentials] used to create a JWT token and connect to app-store-connect-api.
  factory AppStoreCredentials.fromJson(String fileContent) {
    return Optional(fileContent).map((str) => jsonDecode(str)).map((json) {
      return AppStoreCredentials(
        privateKeyId: Optional(json['private_key_id']).orElseThrow(
            AppStoreCredentialsException(
                "Missing key named 'private_key_id' in JSON document.")),
        privateKey: Optional(json['private_key']).orElseThrow(
            AppStoreCredentialsException(
                "Missing key named 'private_key' in JSON document.")),
        issuerId: Optional(json['issuer_id']).orElseThrow(
            AppStoreCredentialsException(
                "Missing key named 'issuer_id' in JSON document.")),
      );
    }).value;
  }

  /// Create a JSON web token with the given key information.
  String get jsonWebToken {
    final expirationDate = DateTime.now().add(const Duration(minutes: 15));
    final payload = utf8.encode(jsonEncode(<String, dynamic>{
      'iss': issuerId,
      'exp': expirationDate.millisecondsSinceEpoch ~/ 1000,
      'aud': 'appstoreconnect-v1'
    }));

    final algorithm = 'ES256';
    final key = _toKeyPair(privateKey, privateKeyId);
    final header = <String, dynamic>{
      'alg': algorithm,
      'kid': privateKeyId
    };

    final encoded = utf8
        .encode('${_encodeString(header)}.${_encodeBytes(payload)}');

    final signed = key.privateKey!
        .createSigner(crypto.AlgorithmIdentifier.getByJwaName(algorithm)!)
        .sign(encoded)
        .data;

    return ''
        '${_encodeString(header)}'
        '.${_encodeBytes(payload)}.'
        '${_encodeBytes(signed)}';
  }
}

///Exception indicating an issue authenticating to the App Store Connect API.
///
/// [Author] Gillian Buijs.
class AppStoreCredentialsException implements Exception {
  AppStoreCredentialsException(this.cause);

  String cause;

  @override
  String toString() =>
      "AppStoreConnectException with cause: '${cause.format()}'";
}

crypto.KeyPair _toKeyPair(String privateKey, String privateKeyId) {
  x509.PrivateKeyInfo info = x509.parsePem(privateKey).first;
  crypto.KeyPair v = info.keyPair;
  final json = {
    'kty': 'EC',
    'crv': 'P-256',
    'x': _intToBase64((v.publicKey as crypto.EcPublicKey).xCoordinate),
    'y': _intToBase64((v.publicKey as crypto.EcPublicKey).yCoordinate),
    'd': _intToBase64((v.privateKey as crypto.EcPrivateKey).eccPrivateKey),
    'kid': privateKeyId,
  };
  return crypto.KeyPair.fromJwk(json);
}

String _encodeString(Map<String, dynamic> json) =>
    _encodeBytes(utf8.encode(jsonEncode(json)));

String _encodeBytes(List<int> data) =>
    base64Url.encode(data).replaceAll('=', '');

String _intToBase64(BigInt v) {
  var s = v.toRadixString(16);
  if (s.length % 2 != 0) s = '0$s';

  return base64Url
      .encode(s
          .replaceAllMapped(RegExp('[0-9a-f]{2}'), (m) => '${m.group(0)},')
          .split(',')
          .where((v) => v.isNotEmpty)
          .map((v) => int.parse(v, radix: 16))
          .toList())
      .replaceAll('=', '');
}
