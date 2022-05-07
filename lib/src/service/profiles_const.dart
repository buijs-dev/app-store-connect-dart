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

import '../common/common.dart';
import 'service_exception.dart';

/// [Author] Gillian Buijs.
class ProfileState extends CONST {
  const ProfileState(String value) : super(value);

  static const active = ProfileState("ACTIVE");
  static const invalid = ProfileState("INVALID");

  static List<ProfileState> get values => [active, invalid];

  /// Helper to deserialize String to [ProfileState] enumeration.
  ///
  /// Throws [BundleIdException] if the given value is not valid.
  /// Returns [ProfileState] if value is valid.
  ///
  /// [Author] Gillian Buijs.
  factory ProfileState.deserialize(String value) {
    return ProfileState.values.firstWhere(
      (type) => type.value == value,
      orElse: () => throw AppStoreConnectException(
        "Invalid ProfileState value: '$value'.",
      ),
    );
  }
}

typedef _P = ProfileType;

/// [Author] Gillian Buijs.
class ProfileType extends CONST {
  const ProfileType(String value) : super(value);

  static const iosAppDevelopment = _P("IOS_APP_DEVELOPMENT");
  static const iosAppStore = _P("IOS_APP_STORE");
  static const iosAppAdhoc = _P("IOS_APP_ADHOC");
  static const iosAppInhouse = _P("IOS_APP_INHOUSE");
  static const macAppDevelopment = _P("MAC_APP_DEVELOPMENT");
  static const tvosAppDevelopment = _P("TVOS_APP_DEVELOPMENT");
  static const tvosAppAdhoc = _P("TVOS_APP_ADHOC");
  static const tvosAppInhouse = _P("TVOS_APP_INHOUSE");
  static const macCatalystAppDevelopment = _P("MAC_CATALYST_APP_DEVELOPMENT");
  static const macCatalystAppStore = _P("MAC_CATALYST_APP_STORE");
  static const macCatalystAppDirect = _P("MAC_CATALYST_APP_DIRECT");

  static List<ProfileType> get values => [
        iosAppDevelopment,
        iosAppStore,
        iosAppAdhoc,
        iosAppInhouse,
        macAppDevelopment,
        tvosAppDevelopment,
        tvosAppAdhoc,
        tvosAppInhouse,
        macCatalystAppDevelopment,
        macCatalystAppStore,
        macCatalystAppDirect,
      ];

  /// Helper to deserialize String to [ProfileType] enumeration.
  ///
  /// Throws [BundleIdException] if the given value is not valid.
  /// Returns [ProfileState] if value is valid.
  ///
  /// [Author] Gillian Buijs.
  factory ProfileType.deserialize(String value) {
    return ProfileType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => throw AppStoreConnectException(
        "Invalid ProfileState value: '$value'.",
      ),
    );
  }
}
