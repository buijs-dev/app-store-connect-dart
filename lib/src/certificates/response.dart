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

import '../bundles/const.dart';
import '../shared/library.dart';
import '../utils/nullsafe.dart';
import 'const.dart';
import 'exception.dart';

/// A response that contains a list of Certificates resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificatesresponse.
///
/// [Author] Gillian Buijs.
class CertificatesResponse with JSON {
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

    /// Get required JSON element data or throw [CertificateException].
    final data = Optional<Iterable<dynamic>>(json['data']).orElseThrow(
      CertificateException(
        "CertificateResponse JSON did not contain required element data",
      ),
    );

    /// Get required JSON element links or throw [CertificateException].
    final links = Optional(json['links']).orElseThrow(
      CertificateException(
        "CertificateResponse JSON did not contain required element links",
      ),
    );

    /// Get optional JSON element data or return null.
    final meta = Optional<dynamic>(json['meta'])
        .map((json) => json['paging'])
        .mapOrNull((json) {
      return PagingInformation.paging(
        total: json['total'],
        limit: json['limit'],
      );
    });

    return CertificatesResponse(
      links: PagedDocumentLinks.fromJson(links),
      meta: meta,
      data: List.from(data).map((cert) {
        return Certificate(
            id: cert['id'].toString(),
            links: ResourceLinks(cert['links']['self']),
            attributes: CertificateAttributes.fromJson(cert['attributes']));
      }).toList(),
    );
  }

  @override
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
class CertificateResponse with JSON {
  CertificateResponse({
    required this.data,
    required this.links,
  });

  final Certificate data;

  /// Self-links to documents that can contain information for one or more resources.
  final DocumentLinks links;

  factory CertificateResponse.fromJson(String content) {
    final json = jsonDecode(content);

    /// Get required JSON element data or throw [CertificateException].
    final data = Optional<dynamic>(json['data']).orElseThrow(
      CertificateException(
        "CertificateResponse JSON did not contain required element data",
      ),
    );

    return CertificateResponse(
      links: DocumentLinks(self: data['links']['self']),
      data: Certificate(
          id: data['id'].toString(),
          links: ResourceLinks(data['links']['self']),
          attributes: CertificateAttributes.fromJson(data['attributes'])),
    );
  }

  @override
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
class Certificate with JSON {
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

  @override
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
class CertificateAttributes with JSON {
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
    final maybePlatform =
        Optional<String>(json['platform']).mapOrNull<BundleIdPlatform>((str) {
      return BundleIdPlatform.deserialize(str);
    });

    final maybeCertificateType = Optional<String>(json['certificateType'])
        .mapOrNull<CertificateType>((str) => CertificateType.deserialize(str));

    return CertificateAttributes(
      expirationDate: json['expirationDate'],
      certificateContent: json['certificateContent'],
      displayName: json['displayName'],
      name: json['name'],
      serialNumber: json['serialNumber'],
      platform: maybePlatform,
      certificateType: maybeCertificateType,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "certificateContent": certificateContent,
        "displayName": displayName,
        "expirationDate": expirationDate,
        "name": name,
        "platform": platform?.value,
        "serialNumber": serialNumber,
        "certificateType": certificateType?.value,
      };
}
