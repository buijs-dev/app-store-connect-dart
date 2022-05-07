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

import 'package:app_store_connect/src/service/bundles_service.dart';
import 'package:app_store_connect/src/service/bundles.dart';
import 'package:app_store_connect/src/service/service.dart';
import 'package:test/test.dart';

import '../../utils/client.dart';

void main() async {
  final client = TestClient();

  final service = BundlesService(
    AppStoreCredentials.fromFile("apple_keys.json"),
    client,
  );

  final okResponse = jsonEncode(
    BundleIdsResponse(data: [
      BundleId(
        attributes: BundleIdAttributes(
          identifier: "bundle-identifier",
          name: "bundle-attribute-name",
          platform: BundleIdPlatform.ios,
          seedId: "seedid123",
        ),
        id: "idea",
        links: ResourceLinks("resource-link"),
      )
    ], links: PagedDocumentLinks(self: "self-reference-paged-link")),
  );

  test('Verify find without query returns BundleIDs', () async {
    // Setup client expectations
    client.expectedUri = "https://api.appstoreconnect.apple.com/v1/bundleIds";
    client.getResponseCode = 200;
    client.getResponseBody = okResponse;

    // Run test on SUT
    final result = await service.find();

    // Assertions
    expect(result.isSuccess, true);
    expect(result.value != null, true);
  });

  test(
      'When capabilities query is specified then include param is implicitly added',
      () async {
    // Setup client expectations
    client.expectedUri = "https://api.appstoreconnect.apple.com/v1/bundleIds"
        "?include=bundleIdCapabilities"
        "&limit=10"
        "&fields[bundleIdCapabilities]=bundleId,capabilityType,settings";
    client.getResponseCode = 200;
    client.getResponseBody = okResponse;

    // Run test on SUT
    final result = await service.find(
      capabilities: (_) => _
        ..showBundleId
        ..showCapabilityType
        ..showSettings
        ..limit = 10,
    );

    // Assertions
    expect(result.isSuccess, true);
    expect(result.value != null, true);
  });
}
