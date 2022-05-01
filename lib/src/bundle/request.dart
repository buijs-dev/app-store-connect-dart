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

/// Request to create a new bundleId in the App Store.
///
/// [Author] Gillian Buijs.
class BundleIdCreateRequest {
  const BundleIdCreateRequest(this.data);

  final _BundleIdCreateRequestData data;

  factory BundleIdCreateRequest.create({
    required String appName,
    required String bundleId,
  }) =>
      BundleIdCreateRequest(
        _BundleIdCreateRequestData(
            _BundleIdCreateRequestDataAttributes(bundleId, appName)),
      );

  static String json({
    required String appName,
    required String bundleId,
  }) =>
      jsonEncode(
        BundleIdCreateRequest.create(
          appName: appName,
          bundleId: bundleId,
        ),
      );

  Map<String, dynamic> toJson() => {"data": data};
}

/// [Author] Gillian Buijs.
class _BundleIdCreateRequestData {
  const _BundleIdCreateRequestData(this.attributes);

  final _BundleIdCreateRequestDataAttributes attributes;

  final String type = "bundleIds";

  Map<String, dynamic> toJson() => {
        "attributes": attributes,
        "type": type,
      };
}

/// [Author] Gillian Buijs.
class _BundleIdCreateRequestDataAttributes {
  const _BundleIdCreateRequestDataAttributes(this.identifier, this.name);

  final String identifier;
  final String name;
  final String platform = "IOS";

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "name": name,
        "platform": platform,
      };
}
