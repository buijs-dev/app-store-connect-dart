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

import 'const.dart';

/// The request body you use to create a Certificate.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificatecreaterequest.
///
/// [Author] Gillian Buijs.
class CertificateCreateRequest {
  const CertificateCreateRequest(this.data);

  /// (Required) The resource data.
  final CertificateCreateRequestData data;

  factory CertificateCreateRequest.create({
    required CertificateType certificateType,
    required String csrContent,
  }) =>
      CertificateCreateRequest(
        CertificateCreateRequestData(
          CertificateCreateRequestDataAttributes(
            certificateType: certificateType,
            csrContent: csrContent,
          ),
        ),
      );

  Map<String, dynamic> toJson() => {"data": data};

  @override
  bool operator ==(Object other) =>
      other is CertificateCreateRequest &&
      other.runtimeType == runtimeType &&
      other.data == data;

  @override
  int get hashCode => data.hashCode;
}

/// The data element of the request body.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificatecreaterequest/data.
///
/// [Author] Gillian Buijs.
class CertificateCreateRequestData {
  const CertificateCreateRequestData(this.attributes);

  /// (Required) fixed value.
  final String type = "certificates";

  /// (Required) The resource data.
  final CertificateCreateRequestDataAttributes attributes;

  Map<String, dynamic> toJson() => {
        "type": type,
        "attributes": attributes,
      };

  @override
  bool operator ==(Object other) =>
      other is CertificateCreateRequestData &&
      other.runtimeType == runtimeType &&
      other.attributes == attributes &&
      other.type == type;

  @override
  int get hashCode => attributes.hashCode;
}

/// Attributes that you set that describe the new resource.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificatecreaterequest/data/attributes.
///
/// [Author] Gillian Buijs.
class CertificateCreateRequestDataAttributes {
  const CertificateCreateRequestDataAttributes({
    required this.certificateType,
    required this.csrContent,
  });

  /// (Required)
  final CertificateType certificateType;

  /// (Required)
  final String csrContent;

  Map<String, dynamic> toJson() => {
        "certificateType": certificateType.value,
        "csrContent": csrContent,
      };

  @override
  bool operator ==(Object other) =>
      other is CertificateCreateRequestDataAttributes &&
      other.runtimeType == runtimeType &&
      other.certificateType == certificateType &&
      other.csrContent == csrContent;

  @override
  int get hashCode => certificateType.hashCode;
}
