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

import '../bundle_ids/bundle_id_platform.dart';
import '../shared/document_links.dart';
import '../shared/paged_document_links.dart';
import '../shared/paging_information.dart';
import '../shared/resource_links.dart';

/// A response that contains a list of Certificates resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificatesresponse.
///
/// [Author] Gillian Buijs.
class CertificatesResponse {

  CertificatesResponse({
    required this.data,
    required this.links,
    this.meta,
  });

  final List<Certificate> data;
  final PagedDocumentLinks links;
  final PagingInformation? meta;

  factory CertificatesResponse.fromJson(String content) {
    final json = jsonDecode(content);
    final data = _required(json, 'data');
    final links = _required(json, 'links');
    final meta = json['meta'];
    return CertificatesResponse(
        links: PagedDocumentLinks.fromJson(links),
        meta: PagingInformation.fromJson(meta),
        data: List.from(data).map((cert) =>
            Certificate(
                id: cert['id'].toString(),
                links: ResourceLinks(self: cert['links']['self']),
                attributes: CertificateAttributes.fromJson(cert['attributes'])
            ),
        ).toList(),
    );

  }

  Map<String, dynamic> toJson() => {
    "data": data,
    "links": links,
    "meta": meta,
  };

}

/// A response that contains a single Certificates resource.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificateresponse.
///
/// [Author] Gillian Buijs.
class CertificateResponse {

  CertificateResponse({
    required this.data,
    required this.links,
  });

  final Certificate data;

  /// Self-links to documents that can contain information for one or more resources.
  final DocumentLinks links;

  factory CertificateResponse.fromJson(String content) {
    final json = jsonDecode(content);
    final data = _required(json, 'data');
    return CertificateResponse(
      links: DocumentLinks(self: data['links']['self']),
      data: Certificate(
          id: data['id'].toString(),
          links: ResourceLinks(self: data['links']['self']),
          attributes: CertificateAttributes.fromJson(data['attributes'])
      ),
    );

  }

  Map<String, dynamic> toJson() => {
    "data": data,
    "links": links,
  };

}

/// Part of [CertificatesResponse] and [CertificateResponse].
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificate.
///
/// [Author] Gillian Buijs.
class Certificate {

  Certificate({
    required this.attributes,
    required this.id,
    required this.links,
  });

  /// The resource's attributes.
  final CertificateAttributes attributes;

  /// (Required) The opaque resource ID that uniquely identifies the resource.
  final String id;

  /// (Required) The resource type.
  final String type = "certificates";

  /// (Required) Navigational links that include the self-link.
  final ResourceLinks links;

  Map<String, dynamic> toJson() => {
    "attributes": attributes,
    "id": id,
    "links": links,
  };

}

/// Part of [Certificate].
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificate/attributes.
///
/// All members are nullable because applying a [CertificatesQuery]
/// will result in some JSON fields not to be present in the response.
///
/// [Author] Gillian Buijs.
class CertificateAttributes {

  CertificateAttributes({
    this.certificateContent,
    this.displayName,
    this.expirationDate,
    this.name,
    this.platform,
    this.serialNumber,
    this.certificateType,
  });

  final String? certificateContent;
  final String? displayName;
  final String? expirationDate;
  final String? name;
  final BundleIdPlatform? platform;
  final String? serialNumber;
  final CertificateType? certificateType;

  factory CertificateAttributes.fromJson(dynamic json) {
    final maybePlatform = json['platform'];
    final maybeCertificateType = json['certificateType'];
    return CertificateAttributes(
      expirationDate: json['expirationDate'],
      certificateContent: json['certificateContent'],
      displayName: json['displayName'],
      name: json['name'],
      platform: maybePlatform == null
          ? null : BundleIdPlatformJson.deserialize(maybePlatform),
      serialNumber:json['serialNumber'],
      certificateType: maybeCertificateType == null
          ? null : _deserialize(maybeCertificateType),
    );
  }

  Map<String, dynamic> toJson() => {
    "certificateContent": certificateContent,
    "displayName": displayName,
    "expirationDate": expirationDate,
    "name": name,
    "platform": platform?.serialize,
    "serialNumber": serialNumber,
    "certificateType": certificateType?.serialize,
  };

}

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
extension _CertificateTypeExt on CertificateType {
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
CertificateType _deserialize(String value) {
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

  throw CertificateException("Invalid CertificateType value: '$value'.");
}

///Exception indicating an issue communicating with the App Store Connect API regarding the Certificates resource.
///
/// [Author] Gillian Buijs.
class CertificateException implements Exception {
  CertificateException(this.cause);

  String cause;

  @override
  String toString() => "CertificateException with cause: '$cause'";
}

/// Utility to get a required JSON element or throw a [CertificateException] if not found.
dynamic _required(dynamic json, String name) {
  final data = json[name];

  if(data == null) {
    throw CertificateException("CertificateResponse JSON did not contain required element '$name'.");
  }

  return data;
}

