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

library appstoreconnect;

import 'package:appstoreconnect/src/certificates/service.dart';
import 'package:appstoreconnect/src/shared/credentials.dart';
import 'package:appstoreconnect/src/shared/client.dart';

export 'src/certificates/library.dart';
export 'src/bundle/library.dart';
export 'src/shared/library.dart';

/// The actual service which uses the App Store Connect API to communicate.
///
/// [Author] Gillian Buijs.
class AppStoreConnect {
  AppStoreConnect({
    required this.credentials,
    this.client = const AppStoreHttpClient(),
  }) {
    certificates= CertificatesService(credentials, client);
  }

  final AppStoreCredentials credentials;
  final AppStoreClient client;

  late final CertificatesService certificates;

}

///Exception indicating an issue connecting to the App Store Connect API.
///
/// [Author] Gillian Buijs.
class AppStoreConnectException implements Exception {
  AppStoreConnectException(this.cause);

  String cause;

  @override
  String toString() =>
      "AppStoreConnectException with cause: '${_format(cause)}'";

  String _format(String msg) =>
      msg.replaceAllMapped(RegExp(r'(\s+?\|)'), (match) => "\n").replaceAll("|", "");

}