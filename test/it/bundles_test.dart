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
import 'package:app_store_client/src/service/bundles_const.dart';
import 'package:app_store_client/src/service/bundles_response.dart';
import 'package:app_store_client/src/service/service_credentials.dart';
import 'package:test/test.dart';

/// Integration Test which uses a real Apple Developer account.
void main() async {
  late final service = AppStoreConnect(
    AppStoreCredentials.fromFile("apple_keys.json"),
  ).bundleIds;

  /// Get the bundles count to check if the count after creation is increased by 1.
  int bundleCount = await service.find().then((res) {
    assert(res.isSuccess, "Failed to get bundleId count");
    return res.value!.data.length;
  });

  /// Shared between tests.
  BundleId? bundleId;

  /// Lookup al bundleIDs.
  test('Verify find with all options', () async {
    final response = await service.find(
        capabilities: (_) => _
          ..showBundleId
          ..showCapabilityType
          ..showSettings
          ..limit = 50,
        profiles: (_) => _
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
          ..includeCapabilities);

    expect(response.isSuccess, true);
    expect(response.value != null, true);
  });

  test('Verify find without options including profiles and capabilities',
      () async {
    final response = await service.find(
        bundles: (_) => _
          ..includeProfiles
          ..includeCapabilities);

    expect(response.isSuccess, true);
    expect(response.value != null, true);
  });

  test('Create a new bundleId', () async {
    final result = await service.create(
      name: "foo bar bla bla",
      identifier: "dev.buijs.unique.bundle.4.test",
      platform: BundleIdPlatform.ios,
    );

    expect(result.isSuccess, true, reason: result.errors.join("\n"));
    expect(result.value != null, true);

    bundleId = result.value?.data;
  });

  test('Find bundleId by ID', () async {
    final response = await service.findById(bundleId!.id);

    expect(response.isSuccess, true, reason: response.errors.join("\n"));
    expect(response.value != null, true);
    expect(response.value!.data.toString(), bundleId.toString());
  });

  test('Find profiles for bundleId by ID', () async {
    final response = await service.findProfilesById(bundleId!.id);

    expect(response.isSuccess, true, reason: response.errors.join("\n"));
    expect(response.value != null, true);
    expect(response.value!.links.self.contains(bundleId!.id), true);
  });

  test('Find capabilities for bundleId by ID', () async {
    final response = await service.findCapabilitiesById(bundleId!.id);

    expect(response.isSuccess, true, reason: response.errors.join("\n"));
    expect(response.value != null, true);
    expect(response.value!.links.self.contains(bundleId!.id), true);
  });

  test('Patch bundleId by ID', () async {
    final response =
        await service.modifyById(bundleId!.id, name: "empire strikes back");

    expect(response.isSuccess, true, reason: response.errors.join("\n"));
    expect(response.value != null, true);
    expect(response.value!.data.attributes.name, "empire strikes back");
  });

  test('Find bundleId by ID and verify the name has changed', () async {
    final response = await service.findById(bundleId!.id);

    expect(response.isSuccess, true, reason: response.errors.join("\n"));
    expect(response.value != null, true);
    expect(response.value!.data.attributes.name, "empire strikes back");
  });

  test('Verify there is 1 more Bundle ID', () async {
    final response = await service.find();

    expect(response.isSuccess, true, reason: response.errors.join("\n"));
    expect(response.value != null, true);
    expect(response.value!.data.length, bundleCount + 1);
  });

  test('Delete by ID', () async {
    final response = await service.deleteById(bundleId!.id);

    expect(response.isSuccess, true, reason: response.errors.join("\n"));
    expect(response.value, true);
  });

  test('Verify the Bundle ID count is 1 less after deletion.', () async {
    final response = await service.find();

    expect(response.isSuccess, true, reason: response.errors.join("\n"));
    expect(response.value != null, true);
    expect(response.value!.data.length, bundleCount);
  });
}
