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

/// Literal values that represent types of signing certificates.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificatetype.
///
/// [Author] Gillian Buijs.
enum CertificateType {
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
}

/// Helper to serialize [CertificateType] enumeration.
///
/// iosDevelopment => IOS_DEVELOPMENT
/// iosDistribution => IOS_DISTRIBUTION
/// macAppDistribution => MAC_APP_DISTRIBUTION
/// macInstallerDistribution => MAC_INSTALLER_DISTRIBUTION
/// macAppDevelopment => MAC_APP_DEVELOPMENT
/// developerIdKext => DEVELOPER_ID_KEXT
/// developerIdApplication => DEVELOPER_ID_APPLICATION
/// development => DEVELOPMENT
/// distribution => DISTRIBUTION
/// passTypeId => PASS_TYPE_ID
/// passTypeIdWithNfc => PASS_TYPE_ID_WITH_NFC
///
/// [Author] Gillian Buijs.
extension CertificateTypeExt on CertificateType {

  String get serialize {
    switch(this) {
      case CertificateType.iosDevelopment:
        return "IOS_DEVELOPMENT";
      case CertificateType.iosDistribution:
        return "IOS_DISTRIBUTION";
      case CertificateType.macAppDistribution:
        return "MAC_APP_DISTRIBUTION";
      case CertificateType.macInstallerDistribution:
        return "MAC_INSTALLER_DISTRIBUTION";
      case CertificateType.macAppDevelopment:
        return "MAC_APP_DEVELOPMENT";
      case CertificateType.developerIdKext:
        return "DEVELOPER_ID_KEXT";
      case CertificateType.developerIdApplication:
        return "DEVELOPER_ID_APPLICATION";
      case CertificateType.development:
        return "DEVELOPMENT";
      case CertificateType.distribution:
        return "DISTRIBUTION";
      case CertificateType.passTypeId:
        return "PASS_TYPE_ID";
      case CertificateType.passTypeIdWithNfc:
        return "PASS_TYPE_ID_WITH_NFC";
    }
  }

}

/// Helper to deserialize String to [CertificateType] enumeration.
///
/// Throws [CertificateTypeException] if the given value is not valid.
/// Returns [CertificateType] if value is valid.
///
/// [Author] Gillian Buijs.
class CertificateTypeJson {

  static CertificateType deserialize(String value) {
    if(value == "IOS_DEVELOPMENT") {
      return CertificateType.iosDevelopment;
    }

    if(value == "IOS_DISTRIBUTION") {
      return CertificateType.iosDistribution;
    }

    if(value == "MAC_APP_DISTRIBUTION") {
      return CertificateType.macAppDistribution;
    }

    if(value == "MAC_INSTALLER_DISTRIBUTION") {
      return CertificateType.macInstallerDistribution;
    }

    if(value == "MAC_APP_DEVELOPMENT") {
      return CertificateType.macAppDevelopment;
    }

    if(value == "DEVELOPER_ID_KEXT") {
      return CertificateType.developerIdKext;
    }

    if(value == "DEVELOPER_ID_APPLICATION") {
      return CertificateType.developerIdApplication;
    }

    if(value == "DEVELOPMENT") {
      return CertificateType.development;
    }

    if(value == "DISTRIBUTION") {
      return CertificateType.distribution;
    }

    if(value == "PASS_TYPE_ID") {
      return CertificateType.passTypeId;
    }

    if(value == "PASS_TYPE_ID_WITH_NFC") {
      return CertificateType.passTypeIdWithNfc;
    }

    throw CertificateTypeException("Invalid CertificateType value: '$value'.");
  }

}

/// Exception indicating an issue deserializing to [CertificateType] enumeration.
///
/// [Author] Gillian Buijs.
class CertificateTypeException implements Exception {
  CertificateTypeException(this.cause);

  String cause;

  @override
  String toString() => "CertificateTypeException with cause: '$cause'";
}