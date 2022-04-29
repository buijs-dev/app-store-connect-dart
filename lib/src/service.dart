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

import 'package:appstoreconnect/src/credentials.dart';
import 'package:appstoreconnect/src/utils/client.dart';

import 'request/bundle_id_create.dart';

/// The actual service which uses the App Store Connect API to communicate.
///
/// [Author] Gillian Buijs.
class AppStoreConnect {
  AppStoreConnect({
    required this.credentials,
    this.client = const AppleClient(),
  });

  final AppleCredentials credentials;
  final AbstractAppleClient client;

  /// Register a new bundleId.
  Future<String> registerBundleId({
    required String bundleId,
    required String appName,
  }) async {

    final response = await client.post(
      uri: bundleIdsUri,
      jwt: credentials.jsonWebToken,
      body: BundleIdCreateRequest.json(
        bundleId: bundleId,
        appName: appName,
      ),
    );

    return response.body;
  }

  /// Retrieve all existing signing certificates.
  Future<String> getCertificates() async {
    final response = await client.get(
      uri: certificatesUri,
      jwt: credentials.jsonWebToken,
    );

    return response.body;
  }

}