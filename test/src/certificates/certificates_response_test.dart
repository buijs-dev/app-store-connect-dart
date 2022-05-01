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

import 'package:appstoreconnect/appstoreconnect.dart';
import 'package:test/test.dart';

void main() async {
  test('Verify deserializing JSON to CertificatesResponse', () async {
    final response = CertificatesResponse.fromJson(json);

    final links = response.links;
    expect(links.self, "https://api.appstoreconnect.apple.com/v1/certificates");

    final meta = response.meta;
    expect(meta?.paging.total, 2);
    expect(meta?.paging.limit, 20);

    final data = response.data;
    expect(data.length, 2);

    // Verify first certificate
    expect(data[0].type, "certificates");
    expect(data[0].id, "123456");
    expect(data[0].attributes.serialNumber, "1ABCDEFGHIJKLFNIUEUGJIGESESFE");
    expect(data[0].attributes.certificateContent,
        "1ABCDEFGHIJKLFNIUEUGJIGESESFEABCDEFGHIJKLFNIUEUGJIGESESFEABCDEFGHIJKLFNIUEUGJIGESESFE");
    expect(data[0].attributes.displayName, "Some Name");
    expect(data[0].attributes.name, "Apple Distribution: Some name");
    expect(data[0].attributes.platform, null);
    expect(data[0].attributes.expirationDate, "2025-01-01T00:00:00.000+00:00");
    expect(data[0].attributes.certificateType, CertificateType.distribution);

    // Verify second certificate
    expect(data[1].type, "certificates");
    expect(data[1].id, "234567");
    expect(data[1].attributes.serialNumber, "2ABCDEFGHIJKLFNIUEUGJIGESESFE");
    expect(data[1].attributes.certificateContent,
        "2ABCDEFGHIJKLFNIUEUGJIGESESFEABCDEFGHIJKLFNIUEUGJIGESESFEABCDEFGHIJKLFNIUEUGJIGESESFE");
    expect(data[1].attributes.displayName, "Some Name");
    expect(data[1].attributes.name, "Apple Development: Some name");
    expect(data[1].attributes.platform, BundleIdPlatform.ios);
    expect(data[1].attributes.expirationDate, "2023-04-21T13:14:06.000+00:00");
    expect(data[1].attributes.certificateType, CertificateType.development);
  });
}

final json = """{
              "data": [{
                  "type": "certificates",
                  "id": "123456",
                  "attributes": {
                    "serialNumber": "1ABCDEFGHIJKLFNIUEUGJIGESESFE",
                    "certificateContent": "1ABCDEFGHIJKLFNIUEUGJIGESESFEABCDEFGHIJKLFNIUEUGJIGESESFEABCDEFGHIJKLFNIUEUGJIGESESFE",
                    "displayName": "Some Name",
                    "name": "Apple Distribution: Some name",
                    "csrContent": null,
                    "platform": null,
                    "expirationDate": "2025-01-01T00:00:00.000+00:00",
                    "certificateType": "DISTRIBUTION"
                  },
                  "relationships": {
                    "passTypeId": {
                      "links": {
                        "self": "https://api.appstoreconnect.apple.com/v1/certificates/123456/relationships/passTypeId",
                        "related": "https://api.appstoreconnect.apple.com/v1/certificates/123456/passTypeId"
                      }
                    }
                  },
                  "links": {
                    "self": "https://api.appstoreconnect.apple.com/v1/certificates/123456"
                  }
                },
                {
                  "type": "certificates",
                  "id": "234567",
                  "attributes": {
                    "serialNumber": "2ABCDEFGHIJKLFNIUEUGJIGESESFE",
                    "certificateContent": "2ABCDEFGHIJKLFNIUEUGJIGESESFEABCDEFGHIJKLFNIUEUGJIGESESFEABCDEFGHIJKLFNIUEUGJIGESESFE",
                    "displayName": "Some Name",
                    "name": "Apple Development: Some name",
                    "csrContent": null,
                    "platform": "IOS",
                    "expirationDate": "2023-04-21T13:14:06.000+00:00",
                    "certificateType": "DEVELOPMENT"
                  },
                  "relationships": {
                    "passTypeId": {
                      "links": {
                        "self": "https://api.appstoreconnect.apple.com/v1/certificates/234567/relationships/passTypeId",
                        "related": "https://api.appstoreconnect.apple.com/v1/certificates/234567/passTypeId"
                      }
                    }
                  },
                  "links": {
                    "self": "https://api.appstoreconnect.apple.com/v1/certificates/234567"
                  }
                }
              ],
            
              "links": {
                "self": "https://api.appstoreconnect.apple.com/v1/certificates"
              },
              "meta": {
                "paging": {
                  "total": 2,
                  "limit": 20
                }
              }
            }""";
