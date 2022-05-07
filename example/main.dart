// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

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

/// Import the appstoreconnect library.
import 'dart:io';

import 'package:app_store_connect/connect.dart';

/// Example of creating an AppStoreConnect instance.
void main(List<String> arguments) async {
  /// Create an AppleCredentials instance.
  ///
  /// Read from JSON file given the file is named 'apple_keys.json'
  /// and stored in the current folder.
  final pathToJson = "${Directory.current.path}apple_keys.json";
  final credentials = AppStoreCredentials.fromFile(pathToJson);

  /// Create an AppStoreConnect instance.
  final service = AppStoreConnect(credentials);

  /// Now you can use the service to communicate with App Store Connect.
  ///
  /// For example: Retrieve all certificates:
  await service.certificates.find().then((certificates) => print(certificates));

  /// Sort the certificates ascending by ID:
  await service.certificates
      .find((_) => _..sortByIdAsc)
      .then((certificates) => print(certificates));

  /// Sort the certificates descending by ID:
  await service.certificates
      .find((_) => _..sortByIdDesc)
      .then((certificates) => print(certificates));

  /// Sort the certificates ascending by CertificateType:
  await service.certificates
      .find((_) => _..sortByCertificateTypeAsc)
      .then((certificates) => print(certificates));

  /// Sort the certificates descending by CertificateType:
  await service.certificates
      .find((_) => _..sortByCertificateTypeDesc)
      .then((certificates) => print(certificates));

  /// Sort the certificates ascending by DisplayName:
  await service.certificates
      .find((_) => _..sortByDisplayNameAsc)
      .then((certificates) => print(certificates));

  /// Sort the certificates descending by DisplayName:
  await service.certificates
      .find((_) => _..sortByDisplayNameDesc)
      .then((certificates) => print(certificates));

  /// Sort the certificates ascending by SerialNumber:
  await service.certificates
      .find((_) => _..sortBySerialNumberAsc)
      .then((certificates) => print(certificates));

  /// Sort the certificates descending by SerialNumber:
  await service.certificates
      .find((_) => _..sortBySerialNumberDesc)
      .then((certificates) => print(certificates));

  /// Or execute a query to find a specific Certificate:
  await service.certificates
      .find((_) => _
        ..filterId = ["1234NOIDEA"]
        ..filterSerialNumber = ["FOOBAR123"]
        ..filterDisplayName = ["Beautiful Display"]
        ..limit = 1)
      .then((certificate) => print(certificate));

  /// Limit the response data returned:
  await service.certificates
      .find((_) => _
        ..showDisplayName
        ..showCsrContent
        ..showName
        ..showCsrContent
        ..showExpirationDate
        ..showCertificateType
        ..showPlatform
        ..showSerialNumber)
      .then((certificates) => print(certificates));

  /// Find by ID:
  await service.certificates.findById("1234NOIDEA");

  /// Find by ID and only return the name:
  await service.certificates.findById("1234NOIDEA", show: (_) => _..showName);

  /// Access the Bundle IDs Resource:
  ///
  /// Register a new Bundle ID.
  /// Modify a Bundle ID.
  /// Delete a Bundle ID.
  /// List Bundle IDs.
  /// Read Bundle ID Information.
  /// List all Profiles for a Bundle ID.
  /// List all Capabilities for a Bundle ID.
  ///
  ///
  /// First register a new Bundle ID for iOS platform:
  await service.bundleIds
      .create(
        identifier: "your.company.or.org.bundle.id",
        name: "unique name for this bundleId",
        platform: BundleIdPlatform.ios,
      )
      .then((bundleId) => print(bundleId));

  /// Register a new Bundle ID for MAC_OS platform:
  await service.bundleIds
      .create(
        identifier: "your.company.or.org.bundle.id",
        name: "unique name for this bundleId",
        platform: BundleIdPlatform.macOs,
      )
      .then((bundleId) => print(bundleId));

  /// Register a new Bundle ID with seedId.
  ///
  /// SeedId is used internally to prefix the bundleId.
  /// If none specified then it is automatically generated
  /// by App Store Connect.
  await service.bundleIds
      .create(
        identifier: "your.company.or.org.bundle.id",
        name: "unique name for this bundleId",
        platform: BundleIdPlatform.macOs,
        seedId: "ABDED1244",
      )
      .then((bundleId) => print(bundleId));

  /// Change the Bundle ID name:
  await service.bundleIds
      .modifyById(
        "BUNDLEID123",
        name: "empire strikes back",
      )
      .then((bundleId) => print(bundleId));

  /// Find a Bundle ID by it's ID:
  await service.bundleIds
      .findById("SOMEIDEA123")
      .then((bundleId) => print(bundleId));

  /// Find all related profiles for a Bundle ID:
  await service.bundleIds
      .findProfilesById("NOIDEA456")
      .then((bundleId) => print(bundleId));

  /// Find all related capabilites for a Bundle ID:
  await service.bundleIds
      .findCapabilitiesById("SHOWMEIDEA")
      .then((bundleId) => print(bundleId));

  /// Find all Bundle IDs:
  await service.bundleIds.find().then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs and include profiles:
  await service.bundleIds
      .find(
        bundles: (_) => _..includeProfiles,
      )
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and limit the result set by 10 ID's:
  await service.bundleIds
      .find(profiles: (_) => _..limit = 10)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show platform:
  await service.bundleIds
      .find(profiles: (_) => _..showPlatform)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show name:
  await service.bundleIds
      .find(profiles: (_) => _..showName)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show Bundle ID:
  await service.bundleIds
      .find(profiles: (_) => _..showBundleId)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show certificates:
  await service.bundleIds
      .find(profiles: (_) => _..showCertificates)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show devices:
  await service.bundleIds
      .find(profiles: (_) => _..showDevices)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show expirationDate:
  await service.bundleIds
      .find(profiles: (_) => _..showExpirationData)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show profileContent:
  await service.bundleIds
      .find(profiles: (_) => _..showProfileContent)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show profileState:
  await service.bundleIds
      .find(profiles: (_) => _..showProfileState)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show profileType:
  await service.bundleIds
      .find(profiles: (_) => _..showProfileType)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include profiles and only show UUID:
  await service.bundleIds
      .find(profiles: (_) => _..showUUID)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs and include capabilities:
  await service.bundleIds
      .find(
        bundles: (_) => _..includeCapabilities,
      )
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include capabilities and limit the result set by 10 ID's:
  await service.bundleIds
      .find(capabilities: (_) => _..limit = 10)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include capabilities and only show bundleIds:
  await service.bundleIds
      .find(capabilities: (_) => _..showBundleId)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include capabilities and only show capabilityType:
  await service.bundleIds
      .find(capabilities: (_) => _..showCapabilityType)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs, include capabilities and only show settings:
  await service.bundleIds
      .find(capabilities: (_) => _..showSettings)
      .then((bundleIds) => print(bundleIds));

  /// Find all Bundle IDs and include profiles and capabilities:
  await service.bundleIds
      .find(
        bundles: (_) => _
          ..includeCapabilities
          ..includeProfiles,
      )
      .then((bundleIds) => print(bundleIds));

  /// Execute a query to find a specific BundleId:
  await service.bundleIds
      .find(
        bundles: (_) => _
          ..filterIdentifier = ["ABCD", "OREFG"]
          ..filterId = ["1234NOIDEA"]
          ..filterName = ["A new Hope"]
          ..filterSeedId = ["RANDOMPREFIX"]
          ..filterPlatformIsIOS // Only add Bundle IDs for platform IOS
          ..filterPlatformIsMacOS, // Only add Bundle IDs for platform MAC_OS
      )
      .then((certificate) => print(certificate));

  /// Limit Bundle IDs response data returned:
  await service.bundleIds
      .find(
        bundles: (_) => _
          ..showName
          ..showPlatform,
      )
      .then((certificates) => print(certificates));

  /// Sort the response data:
  await service.bundleIds
      .find(
        bundles: (_) => _
          ..sortByIdAsc
          ..sortByIdDesc
          ..sortByIdentifierAsc
          ..sortByIdentifierDesc
          ..sortByNameAsc
          ..sortByNameDesc
          ..sortByPlatformAsc
          ..sortByPlatformDesc
          ..sortBySeedIdAsc
          ..sortBySeedIdDesc,
      )
      .then((certificates) => print(certificates));

  /// Delete a Bundle ID:
  await service.bundleIds
      .deleteById("SOLONGIDEA")
      .then((bundleIds) => print(bundleIds));
}
