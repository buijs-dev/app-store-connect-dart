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

import 'package:app_store_client/connect.dart';
import 'package:app_store_client/src/bundles/service.dart';
import 'package:test/test.dart';

/// Integration Test which uses a real Apple Developer account.
void main() async {
  final service =
      BundlesService(AppStoreCredentials.fromFile("apple_keys.json"));

  /// Lookup al bundleIDs.
  test('Verify find', () async {
    final response = await service.find(
        capabilities: (_) => _
          ..showBundleId
          ..showCapabilityType
          ..showSettings
          ..limit = 50,
        profiles:  (_) => _
          ..showBundleId
          ..showCertificates
          ..showDevices
          ..showExpirationData
          ..showName
          ..showPlatform
          ..showProfileContent
          ..showProfileState
          ..showProfileType
          ..showUUID
          ..limit = 50,
        bundles: (_) => _
          ..showCapabilities
          ..showIdentifier
          ..showName
          ..showPlatform
          ..showProfiles
          ..showSeedId
          ..filterId = ["a"]
          ..filterIdentifier = ["a"]
          ..filterName = ["a"]
          ..filterPlatformIsMacOS
          ..filterPlatformIsIOS
          ..filterSeedId = ["a"]
          ..limit = 200
          ..sortByIdAsc
          ..sortByIdDesc
          ..sortByIdentifierAsc
          ..sortByIdentifierDesc
          ..sortByNameAsc
          ..sortByNameDesc
          ..sortByPlatformAsc
          ..sortByPlatformDesc
          ..sortBySeedIdAsc
          ..sortBySeedIdDesc
          ..includeProfiles
          ..includeCapabilities
    );

    expect(response.isSuccess, true);
    expect(response.value != null, true);

  });


}
