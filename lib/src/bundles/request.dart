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

import '../../connect.dart';

/// Request to create a new bundleId in the App Store.
///
/// [Author] Gillian Buijs.
class BundleIdCreateRequest with JSON {
  const BundleIdCreateRequest(this.data);

  final BundleIdCreateRequestData data;

  factory BundleIdCreateRequest.create({
    required String identifier,
    required String name,
    required BundleIdPlatform platform,
    String? seedId,
  }) =>
      BundleIdCreateRequest(
        BundleIdCreateRequestData(
          BundleIdCreateRequestDataAttributes(
            identifier: identifier,
            name: name,
            platform: platform,
            seedId: seedId,
          ),
        ),
      );

  @override
  Map<String, dynamic> toJson() => {"data": data};
}

/// The request body you use to update a Bundle ID.
///
/// [Author] Gillian Buijs.
class BundleIdUpdateRequest with JSON {
  const BundleIdUpdateRequest(this.data);

  final BundleIdUpdateRequestData data;

  factory BundleIdUpdateRequest.create({
    required String id,
    required String name,
  }) =>
      BundleIdUpdateRequest(
        BundleIdUpdateRequestData.create(
          id: id,
          name: name,
        ),
      );

  @override
  Map<String, dynamic> toJson() => {"data": data};
}

/// [Author] Gillian Buijs.
class BundleIdUpdateRequestData with JSON {
  const BundleIdUpdateRequestData({
    required this.attributes,
    required this.id,
  });

  final BundleIdUpdateRequestDataAttributes attributes;

  final String id;
  final String type = "bundleIds";

  factory BundleIdUpdateRequestData.create({
    required String name,
    required String id,
  }) =>
      BundleIdUpdateRequestData(
        id: id,
        attributes: BundleIdUpdateRequestDataAttributes(name),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes,
        "type": type,
      };
}

/// [Author] Gillian Buijs.
class BundleIdCreateRequestData with JSON {
  const BundleIdCreateRequestData(this.attributes);

  final BundleIdCreateRequestDataAttributes attributes;

  final String type = "bundleIds";

  @override
  Map<String, dynamic> toJson() => {
        "attributes": attributes,
        "type": type,
      };
}

/// [Author] Gillian Buijs.
class BundleIdCreateRequestDataAttributes with JSON {
  const BundleIdCreateRequestDataAttributes({
    required this.identifier,
    required this.name,
    required this.platform,
    this.seedId,
  });

  final String identifier;
  final String name;
  final BundleIdPlatform platform;
  final String? seedId;

  @override
  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "name": name,
        "platform": platform.value,
        "seedId": seedId,
      };
}

/// [Author] Gillian Buijs.
class BundleIdUpdateRequestDataAttributes with JSON {
  const BundleIdUpdateRequestDataAttributes(this.name);

  final String name;

  @override
  Map<String, dynamic> toJson() => {"name": name};
}
