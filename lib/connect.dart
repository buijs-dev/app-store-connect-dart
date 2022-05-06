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

import 'package:app_store_client/src/bundles/service.dart';

import 'src/certificates/service.dart';
import 'src/shared/credentials.dart';
import 'src/shared/client.dart';

export 'src/certificates/library.dart';
export 'src/bundles/library.dart';
export 'src/shared/library.dart';

/// The actual service which uses the App Store Connect API to communicate.
///
/// [Author] Gillian Buijs.
class AppStoreConnect {
  AppStoreConnect(

      /// Credentials to be converted to a JSON web token
      /// which are used to authenticate to App Store Connect API.
      AppStoreCredentials credentials,

      /// Client used to connect to the App Store Connect API.
      /// Default client is an [AppStoreHttpClient].
      {AppStoreClient? client})
  // For each App Store Connect API resource instantiate a Service.
  {
    certificates = CertificatesService(credentials, client);
    bundleIds = BundlesService(credentials, client);
  }

  /// Service to access the App Store Connect API Certificates Resource.
  late final CertificatesService certificates;

  /// Service to access the App Store Connect API BundleIDs Resource.
  late final BundlesService bundleIds;
}
