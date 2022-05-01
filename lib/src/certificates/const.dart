import 'exception.dart';

typedef _C = CertificateType;

/// Literal values that represent types of signing certificates.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificatetype.
///
/// [Author] Gillian Buijs.
class CertificateType {
  const CertificateType(this.value);

  final String value;

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
