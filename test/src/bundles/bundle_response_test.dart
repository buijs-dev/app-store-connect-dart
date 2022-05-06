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

import 'package:app_store_client/connect.dart';
import 'package:app_store_client/src/bundles/response.dart';
import 'package:test/test.dart';

void main() async {
  test('Verify BundleIdResponse JSON deserialization', () async {
    final response = BundleIdResponse.fromJson(json);

    expect(response.data.type, "bundleIds");
    expect(response.data.id, "ABCDEEEFD");
    expect(
        response.data.attributes.identifier, "dev.buijs.unique.bundle.4.test");
    expect(response.data.attributes.platform, BundleIdPlatform.universtal);
    expect(response.data.attributes.name, "foo bar bla bla");
    expect(response.data.attributes.seedId, "SEED23232");
  });
}

const json = """
{
  "data" : {
    "type" : "bundleIds",
    "id" : "ABCDEEEFD",
    "attributes" : {
      "name" : "foo bar bla bla",
      "identifier" : "dev.buijs.unique.bundle.4.test",
      "platform" : "UNIVERSAL",
      "seedId" : "SEED23232"
    },
    "relationships" : {
      "bundleIdCapabilities" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "data" : [ {
          "type" : "bundleIdCapabilities",
          "id" : "ABCDEEEFD_GAME_CENTER"
        }, {
          "type" : "bundleIdCapabilities",
          "id" : "ABCDEEEFD_IN_APP_PURCHASE"
        } ],
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/ABCDEEEFD/relationships/bundleIdCapabilities",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/ABCDEEEFD/bundleIdCapabilities"
        }
      },
      "profiles" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "data" : [ ],
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/ABCDEEEFD/relationships/profiles",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/ABCDEEEFD/profiles"
        }
      }
    },
    "links" : {
      "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/ABCDEEEFD"
    }
  },
  "links" : {
    "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds"
  }
}""";
