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

import 'package:app_store_connect/src/service/certificates_const.dart';
import 'package:app_store_connect/src/service/certificates_request.dart';
import 'package:test/test.dart';

void main() async {
  test('Verify serializing CertificateCreateRequest to JSON', () async {
    final request = CertificateCreateRequest.create(
      certificateType: CertificateType.iosDistribution,
      csrContent: """-----BEGIN CERTIFICATE REQUEST-----
                    BLABLABLABLABLABLABLABLABLALBLA==
                    -----END CERTIFICATE REQUEST-----""",
    ).toJson();

    expect(jsonEncode(request).replaceAll(" ", "").replaceAll("\\n", ""), json);
  });
}

final json = """{
    "data": {
        "type": "certificates",
        "attributes": {
          "certificateType": "IOS_DISTRIBUTION",
          "csrContent": "-----BEGIN CERTIFICATE REQUEST-----
          BLABLABLABLABLABLABLABLABLALBLA==
          -----END CERTIFICATE REQUEST-----"
        }
     }
  }"""
    .replaceAll(" ", "")
    .replaceAll("\n", "");
