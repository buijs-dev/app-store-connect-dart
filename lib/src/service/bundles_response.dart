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

import '../common/common.dart';
import 'bundles_const.dart';
import 'service_exception.dart';
import 'service_models.dart';

/// A response that contains a list of Bundle ID resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleidsresponse.
///
/// [Author] Gillian Buijs.
class BundleIdsResponse with JSON {
  BundleIdsResponse({
    required this.data,
    required this.links,
    this.meta,
    this.included,
  });

  /// (Required) The resource data.
  final List<BundleId> data;

  /// (Required) Navigational links that include the self-link.
  final PagedDocumentLinks links;

  /// Paging information.
  final PagingInformation? meta;

  /// The requested relationship data.
  final dynamic included;

  factory BundleIdsResponse.fromJson(String content) {
    final json = jsonDecode(content);

    /// Get required JSON element data or throw [BundleIdException].
    final data = Optional<Iterable<dynamic>>(json['data']).orElseThrow(
      AppStoreConnectException(
        "BundleIdsResponse JSON did not contain required element data",
      ),
    );

    /// Get required JSON element links or throw [BundleIdException].
    final links = Optional(json['links']).orElseThrow(
      AppStoreConnectException(
        "BundleIdsResponse JSON did not contain required element links",
      ),
    );

    /// Get optional JSON element meta or return null.
    final meta = Optional<dynamic>(json['meta'])
        .map((json) => json['paging'])
        .mapOrNull((json) {
      return PagingInformation.paging(
        total: json['total'],
        limit: json['limit'],
      );
    });

    return BundleIdsResponse(
        links: PagedDocumentLinks.fromJson(links),
        meta: meta,
        data: List.from(data).map((bundleId) {
          return BundleId(
            id: bundleId['id'].toString(),
            links: ResourceLinks(bundleId['links']['self']),
            attributes: BundleIdAttributes.fromJson(bundleId['attributes']),
          );
        }).toList(),
        included: json['included']);
  }

  @override
  Map<String, dynamic> toJson() => {
        "data": data,
        "links": links,
        "meta": meta,
      };
}

/// A response that contains a list of Bundle ID resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleidsresponse.
///
/// [Author] Gillian Buijs.
class BundleIdResponse with JSON {
  BundleIdResponse({
    required this.data,
    required this.links,
    this.included,
  });

  /// (Required) The resource data.
  final BundleId data;

  /// (Required) Navigational links that include the self-link.
  final DocumentLinks links;

  /// The requested relationship data.
  ///
  /// Possible types: [Profile], [BundleIdCapability], [App]
  final dynamic included;

  factory BundleIdResponse.fromJson(String content) {
    final json = jsonDecode(content);

    /// Get required JSON element data or throw [BundleIdException].
    final data = Optional<dynamic>(json['data']).orElseThrow(
      AppStoreConnectException(
        "BundleIdsResponse JSON did not contain required element data",
      ),
    );

    /// Get required JSON element links or throw [BundleIdException].
    final links = Optional<dynamic>(json['links']).orElseThrow(
      AppStoreConnectException(
        "BundleIdsResponse JSON did not contain required element links",
      ),
    );

    return BundleIdResponse(
        links: DocumentLinks(self: links['self']),
        data: BundleId(
            id: data['id'].toString(),
            links: ResourceLinks(data['links']['self']),
            attributes: BundleIdAttributes.fromJson(data['attributes'])),
        included: json['included']);
  }

  @override
  Map<String, dynamic> toJson() => {
        "data": data,
        "links": links,
        "included": included,
      };
}

/// The data structure that represents a Bundle IDs resource. Part of [BundleIdsResponse].
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid.
///
/// [Author] Gillian Buijs.
class BundleId with JSON {
  BundleId({
    required this.attributes,
    required this.id,
    required this.links,
    this.relationships,
  });

  /// The resource's attributes.
  final BundleIdAttributes attributes;

  /// Navigational links to related data and included resource types and IDs.
  final BundleIdRelationships? relationships;

  /// (Required) The opaque resource ID that uniquely identifies the resource.
  final String id;

  /// (Required) The resource type.
  final String type = "bundleIds";

  /// (Required) Navigational links that include the self-link.
  final ResourceLinks links;

  @override
  Map<String, dynamic> toJson() => {
        "attributes": attributes,
        "relationships": relationships,
        "id": id,
        "type": type,
        "links": links,
      };
}

/// Attributes that describe a Bundle IDs resource.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/attributes.
///
/// [Author] Gillian Buijs.
class BundleIdAttributes with JSON {
  const BundleIdAttributes({
    required this.identifier,
    required this.name,
    required this.seedId,
    required this.platform,
  });

  final String identifier;
  final String name;
  final String seedId;
  final BundleIdPlatform platform;

  @override
  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "name": name,
        "platform": platform.value,
        "seedId": seedId,
      };

  factory BundleIdAttributes.fromJson(dynamic json) {
    /// Get required JSON element platform and deserialize it
    /// to a BundleIdPlatform const or throw [BundleIdException].
    final maybePlatform = Optional<String>(json['platform'])
        .map<BundleIdPlatform>((str) => BundleIdPlatform.deserialize(str))
        .orElseThrow(
          AppStoreConnectException(
            "BundleIdsResponse JSON did not contain required element platform",
          ),
        );

    return BundleIdAttributes(
      identifier: json['identifier'],
      name: json['name'],
      platform: maybePlatform,
      seedId: json['seedId'],
    );
  }
}

/// The relationships you included in the request and those on which you can operate.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships.
///
/// [Author] Gillian Buijs.
class BundleIdRelationships with JSON {
  const BundleIdRelationships({
    required this.profiles,
    required this.capabilities,
    required this.app,
  });

  final Relationship profiles;
  final Relationship capabilities;
  final Relationship app;

  @override
  Map<String, dynamic> toJson() => {
        "profiles": profiles,
        "bundleIdCapabilities": capabilities,
        "app": app,
      };

  factory BundleIdRelationships.fromJson(dynamic json) {
    return BundleIdRelationships(
      profiles: Relationship.fromJson(json['profiles']),
      capabilities: Relationship.fromJson(json['bundleIdCapabilities']),
      app: Relationship.fromJson(json['app']),
    );
  }
}
