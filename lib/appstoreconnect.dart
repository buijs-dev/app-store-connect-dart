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

import 'src/certificates/service.dart';
import 'src/shared/credentials.dart';
import 'src/shared/client.dart';
import 'src/utils/library.dart';

export 'src/certificates/library.dart';
export 'src/bundle/library.dart';
export 'src/shared/library.dart';

/// The actual service which uses the App Store Connect API to communicate.
///
/// [Author] Gillian Buijs.
class AppStoreConnect {
  AppStoreConnect(this.credentials, {this.client = const AppStoreHttpClient()})
  // For each App Store Connect API resource instantiate a Service.
  {
    certificates = CertificatesService(credentials, client);
  }

  /// Credentials to be converted to a JSON web token
  /// which are used to authenticate to App Store Connect API.
  final AppStoreCredentials credentials;

  /// Client which communicates with the App Store Connect API.
  /// Defaults to the [AppStoreHttpClient].
  final AppStoreClient client;

  /// Service to access the App Store Connect API Certificates Resource.
  late final CertificatesService certificates;
}

///Exception indicating an issue connecting to the App Store Connect API.
///
/// [Author] Gillian Buijs.
class AppStoreConnectException implements Exception {
  const AppStoreConnectException(this.cause);

  final String cause;

  @override
  String toString() =>
      "AppStoreConnectException with cause: '${cause.format()}'";
}
