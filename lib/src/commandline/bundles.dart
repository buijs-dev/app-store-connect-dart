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

import '../../connect.dart';
import '../bundles/service.dart';
import '../utils/nullsafe.dart';

import 'library.dart';

/// Register a new Bundle ID.
///
/// Arguments:
/// [Arguments.bundleId] => the actual Bundle ID to register.
/// [Arguments.bundleName] => the name for the Bundle ID.
/// [Arguments.bundlePlatform] => the platform to register for being IOS or MAC_OS.
/// [Arguments.bundleSeedId] => optional seedId.
///
/// Returns [BundleResponse].
///
///[Author] Gillian Buijs.
Future<BundleResponse> createBundleId(List<String> args) async {
  final credentials = AppStoreCredentialsArgs(args).parse;
  final arguments = BundleArgs(args);

  final argumentValidations = <String>[];
  final bundleId = arguments.bundleId;

  // Verify a Bundle ID is given.
  if (bundleId == null) {
    argumentValidations.add(
      "Missing BundleID identifier. Specify a Bundle ID with option '--${Arguments.bundleId}'.",
    );
  }

  // Verify a Bundle name is given.
  final bundleName = arguments.bundleName;
  if (bundleId == null) {
    argumentValidations.add(
      "Missing BundleID name. Specify a Bundle name with option '--${Arguments.bundleName}'.",
    );
  }

  // Verify a platform is specified being IOS or MAC_OS.
  final platform = arguments.platform;
  if (bundleId == null) {
    argumentValidations.add(
      "Missing or invalid BundleID platform. "
      "Specify a platform with option '--${Arguments.bundlePlatform}'. "
      "Possible values are: ${BundleIdPlatform.ios.value} or ${BundleIdPlatform.macOs}",
    );
  }

  // If there are validation messages then stop.
  if (argumentValidations.isNotEmpty) {
    return BundleResponse(warnings: argumentValidations, isSuccess: false);
  }

  // SeedId is optional os may be null.
  final seedId = arguments.seedId;

  final service = BundlesService(credentials);

  final result = await service.create(
    identifier: bundleId!,
    name: bundleName!,
    platform: platform!,
    seedId: seedId,
  );

  if (!result.isSuccess) {
    return BundleResponse(warnings: result.warnings, isSuccess: false);
  }

  return BundleResponse(
    isSuccess: true,
    warnings: result.warnings,
    id: result.value!.data.id,
  );
}

/// Delete a Bundle ID.
///
/// Arguments:
/// [Arguments.bundleId] => the Bundle ID to delete.
///
/// Returns [BundleResponse].
///
///[Author] Gillian Buijs.
Future<BundleResponse> deleteBundleId(List<String> args) async {
  final credentials = AppStoreCredentialsArgs(args).parse;
  final arguments = BundleArgs(args);
  final bundleId = arguments.bundleId;

  // Verify a Bundle ID is given.
  if (bundleId == null) {
    return BundleResponse(
      isSuccess: false,
      warnings: [
        "Missing BundleID identifier. Specify a Bundle ID with option '--${Arguments.bundleId}'."
      ],
    );
  }

  final service = BundlesService(credentials);

  final bundle = await service.find(bundles: (_) {
    return _..filterIdentifier = [bundleId];
  });

  // Stop if Bundle ID can not be found.
  if (!bundle.isSuccess) {
    return BundleResponse(warnings: bundle.warnings, isSuccess: false);
  }

  // Stop if more than 1 Bundle ID are found.
  if (bundle.value!.data.length > 1) {
    return BundleResponse(
      isSuccess: false,
      warnings: bundle.warnings
        ..add(
          "Unable to delete because more than 1 Bundle ID found for '$bundleId'. ",
        ),
    );
  }

  // Commence deletion.
  final result = await service.deleteById(bundle.value!.data.first.id);

  // Oh shucks it failed.
  if (!result.isSuccess) {
    return BundleResponse(warnings: result.warnings, isSuccess: false);
  }

  // Success!
  return BundleResponse(
    isSuccess: true,
    warnings: result.warnings,
    id: bundleId,
  );
}

/// Edit a Bundle ID.
///
/// Arguments:
/// [Arguments.bundleId] => the actual Bundle ID to register.
/// [Arguments.bundleName] => the name for the Bundle ID.
///
/// Returns [BundleResponse].
///
///[Author] Gillian Buijs.
Future<BundleResponse> editBundleId(List<String> args) async {
  final credentials = AppStoreCredentialsArgs(args).parse;
  final arguments = BundleArgs(args);

  final argumentValidations = <String>[];
  final bundleId = arguments.bundleId;

  // Verify a Bundle ID is given.
  if (bundleId == null) {
    argumentValidations.add(
      "Missing BundleID identifier. Specify a Bundle ID with option '--${Arguments.bundleId}'.",
    );
  }

  // Verify a Bundle name is given.
  final bundleName = arguments.bundleName;
  if (bundleId == null) {
    argumentValidations.add(
      "Missing BundleID name. Specify a Bundle name with option '--${Arguments.bundleName}'.",
    );
  }

  // Stop if there are validation errors.
  if (argumentValidations.isNotEmpty) {
    return BundleResponse(warnings: argumentValidations, isSuccess: false);
  }

  final service = BundlesService(credentials);

  // Lookup the Bundle ID.
  final bundle = await service.find(bundles: (_) {
    return _..filterIdentifier = [bundleId!];
  });

  // Stop if Bundle ID can not be found.
  if (!bundle.isSuccess) {
    return BundleResponse(warnings: bundle.warnings, isSuccess: false);
  }

  // Stop if moer than 1 Bundle ID are be found.
  if (bundle.value!.data.length > 1) {
    return BundleResponse(
      isSuccess: false,
      warnings: bundle.warnings
        ..add(
          "Unable to edit because more than 1 Bundle ID found for '$bundleId'. ",
        ),
    );
  }

  // Edit the Bundle ID.
  final result = await service.modifyById(
    bundle.value!.data.first.id,
    name: bundleName!,
  );

  // Cry me a river it failed...
  if (!result.isSuccess) {
    return BundleResponse(warnings: result.warnings, isSuccess: false);
  }

  // Champagne!
  return BundleResponse(
    isSuccess: true,
    warnings: result.warnings,
    id: result.value!.data.id,
  );
}

/// [Author] Gillian Buijs
class BundleResponse {
  const BundleResponse({
    required this.isSuccess,
    this.warnings = const [],
    this.info = const [],
    this.id,
  });

  final bool isSuccess;
  final List<String> warnings;
  final List<String> info;
  final String? id;
}

/// [Author] Gillian Buijs
class BundleArgs {
  BundleArgs(this.args);

  final List<String> args;

  late final Map<String, String> parsedArgs = args.toArgs;

  String? get bundleId => parsedArgs[Arguments.bundleId];
  String? get bundleName => parsedArgs[Arguments.bundleName];
  String? get seedId => parsedArgs[Arguments.bundleSeedId];

  BundleIdPlatform? get platform =>
      Optional(parsedArgs[Arguments.bundlePlatform])
          .mapOrNull((str) => BundleIdPlatform.deserialize(str));
}
