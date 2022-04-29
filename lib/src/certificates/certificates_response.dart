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

import 'package:appstoreconnect/appstoreconnect.dart';

import '../bundle_id/bundle_id_platform.dart';
import '../shared/paged_document_links.dart';
import '../shared/paging_information.dart';
import '../shared/resource_links.dart';
import 'certificate_type.dart';

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

/// Part of [CertificatesResponse].
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

/// Part of [CertificatesResponse].
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
          ? null : CertificateTypeJson.deserialize(maybeCertificateType),
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

///Exception indicating an issue connecting to the App Store Connect API.
///
/// [Author] Gillian Buijs.
class CertificateResponseException implements Exception {
  CertificateResponseException(this.cause);

  String cause;

  @override
  String toString() => "CertificateResponseException with cause: '$cause'";
}

/// Utility to get a required JSON element or throw a [CertificateResponseException] if not found.
dynamic _required(dynamic json, String name) {
  final data = json[name];

  if(data == null) {
    throw CertificateResponseException("CertificateResponse JSON did not contain required element '$name'.");
  }

  return data;
}

