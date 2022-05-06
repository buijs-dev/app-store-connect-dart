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

typedef _C = CertificateType;

/// Literal values that represent types of signing certificates.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificatetype.
///
/// [Author] Gillian Buijs.
class CertificateType extends CONST {
  const CertificateType(String value): super(value);

  static const developerIdApplication = _C("DEVELOPER_ID_APPLICATION");
  static const developerIdKext = _C("DEVELOPER_ID_KEXT");
  static const development = _C("DEVELOPMENT");
  static const distribution = _C("DISTRIBUTION");
  static const iosDevelopment = _C("IOS_DEVELOPMENT");
  static const iosDistribution = _C("IOS_DISTRIBUTION");
  static const macAppDevelopment = _C("MAC_APP_DEVELOPMENT");
  static const macAppDistribution = _C("MAC_APP_DISTRIBUTION");
  static const macInstallerDistribution = _C("MAC_INSTALLER_DISTRIBUTION");
  static const passTypeId = _C("PASS_TYPE_ID");
  static const passTypeIdWithNfc = _C("PASS_TYPE_ID_WITH_NFC");

  static List<CertificateType> get values => [
        iosDevelopment,
        iosDistribution,
        macAppDistribution,
        macInstallerDistribution,
        macAppDevelopment,
        developerIdKext,
        developerIdApplication,
        development,
        distribution,
        passTypeId,
        passTypeIdWithNfc,
      ];

  /// Helper to deserialize String to [CertificateType] enumeration.
  ///
  /// Throws [CertificateTypeException] if the given value is not valid.
  /// Returns [CertificateType] if value is valid.
  ///
  /// [Author] Gillian Buijs.
  factory CertificateType.deserialize(String value) {
    return CertificateType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => throw CertificateException(
          "Invalid CertificateType value: '$value'."),
    );
  }
}
