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

import 'dart:io';

import '../../connect.dart';
import '../utils/library.dart';
import 'arguments.dart';

/// Helper to create [AppStoreCredentials].
///
/// [Author] Gillian Buijs
class AppStoreCredentialsArgs {
  AppStoreCredentialsArgs(this.args);

  final List<String> args;

  late final Map<String, String> parsedArgs = args.toArgs;

  /// Create an [AppStoreCredentials] instance by
  /// reading command-line arguments,
  /// checking environment variables
  /// and checking for an apple_keys.json.
  ///
  /// Return [AppStoreCredentials] if keys are found and otherwise null.
  AppStoreCredentials get parse => _fromArgs ?? _fromEnv ?? _fromFile;

  /// Check the supplied command-line arguments for
  /// [_issuerId], [_keyId] and [_privateKey].
  ///
  /// Return [AppStoreCredentials] if all 3 are supplied and otherwise null.
  AppStoreCredentials? get _fromArgs {
    final issuerId = parsedArgs[Arguments.issuerId];
    if (issuerId == null) return null;

    final keyId = parsedArgs[Arguments.keyId];
    if (keyId == null) return null;

    final privateKey = parsedArgs[Arguments.privateKey];
    if (privateKey == null) return null;

    return AppStoreCredentials(
      privateKeyId: keyId,
      privateKey: privateKey,
      issuerId: issuerId,
    );
  }

  /// Check the environment variable for
  /// [_issuerIdEnv], [_keyIdEnv] and [_privateKeyEnv].
  ///
  /// Return [AppStoreCredentials] if all 3 are supplied and otherwise null.
  AppStoreCredentials? get _fromEnv {
    Map<String, String> variables = Platform.environment;

    final issuerId = variables[Arguments.issuerIdEnv];
    if (issuerId == null) return null;

    final keyId = variables[Arguments.keyIdEnv];
    if (keyId == null) return null;

    final privateKey = variables[Arguments.privateKeyEnv];
    if (privateKey == null) return null;

    return AppStoreCredentials(
      privateKeyId: keyId,
      privateKey: privateKey,
      issuerId: issuerId,
    );
  }

  /// Check the supplied command-line arguments for [_appleKeysFile].
  ///
  /// If custom path to apple_keys.json is not supplied then use current path.
  /// Pass the JSON file path to the [AppStoreCredentials] factory method to
  /// create an instance.
  ///
  /// Returns [AppStoreCredentials]
  /// or throws [AppStoreCredentialsException]
  /// or throws [FileException].
  AppStoreCredentials get _fromFile {
    final file = Optional<String>(parsedArgs[Arguments.appleKeysFile])
            .mapOrNull<File>((path) => FileFactory(path).file) ??
        FileFactory(Directory.current.absolute.path)
            .resolve("apple_keys.json")
            .file;
    return AppStoreCredentials.fromFile(file);
  }
}
