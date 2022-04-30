import 'exception.dart';

/// Literal values that represent types of signing certificates.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificatetype.
///
/// [Author] Gillian Buijs.
class CertificateType {
  const CertificateType(this.value);

  final String value;

  static const developerIdApplication = CertificateType("DEVELOPER_ID_APPLICATION");
  static const developerIdKext = CertificateType("DEVELOPER_ID_KEXT");
  static const development = CertificateType("DEVELOPMENT");
  static const distribution = CertificateType("DISTRIBUTION");
  static const iosDevelopment = CertificateType("IOS_DEVELOPMENT");
  static const iosDistribution = CertificateType("IOS_DISTRIBUTION");
  static const macAppDevelopment = CertificateType("MAC_APP_DEVELOPMENT");
  static const macAppDistribution = CertificateType("MAC_APP_DISTRIBUTION");
  static const macInstallerDistribution = CertificateType("MAC_INSTALLER_DISTRIBUTION");
  static const passTypeId = CertificateType("PASS_TYPE_ID");
  static const passTypeIdWithNfc = CertificateType("PASS_TYPE_ID_WITH_NFC");

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
    return CertificateType.values.firstWhere((type) => type.value == value,
        orElse: () => throw CertificateException("Invalid CertificateType value: '$value'.")
    );
  }

}