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

/// A response that contains a list of Bundle ID resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleidsresponse.
///
/// [Author] Gillian Buijs.
class BundleIdsResponse {
  BundleIdsResponse({
    required this.data,
    required this.links,
    this.meta,
    this.included
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

    final data = Optional<Iterable<dynamic>>(json['data']).orElseThrow(
        BundleIdException(
            "BundleIdsResponse JSON did not contain required element data"));

    final links = Optional(json['links']).orElseThrow(BundleIdException(
        "BundleIdsResponse JSON did not contain required element links"));

    final meta = json['meta'];

    return BundleIdsResponse(
      links: PagedDocumentLinks.fromJson(links),
      meta: PagingInformation.fromJson(meta),
      data: List.from(data)
          .map(
            (bundleId) => BundleId(
                id: bundleId['id'].toString(),
                links: ResourceLinks(bundleId['links']['self']),
                attributes: BundleIdAttributes.fromJson(bundleId['attributes'])),
          )
          .toList(),
      included: json['included']
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data,
        "links": links,
        "meta": meta,
      };

  @override
  bool operator ==(Object other) =>
      other is BundleIdsResponse &&
      other.runtimeType == runtimeType &&
      other.data == data &&
      other.links == links &&
      other.meta == meta &&
      other.included == included;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() =>
      "Instance of BundleIdsResponse: data = $data | links = $links | meta = $meta";
}

/// The data structure that represents a Bundle IDs resource. Part of [BundleIdsResponse].
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid.
///
/// [Author] Gillian Buijs.
class BundleId {
  BundleId({
    required this.attributes,
    required this.id,
    required this.links,
    this.relationships
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

  Map<String, dynamic> toJson() => {
    "attributes": attributes,
    "relationships": relationships,
    "id": id,
    "type": type,
    "links": links,
  };

  @override
  bool operator ==(Object other) =>
  other is BundleId &&
  other.runtimeType == runtimeType &&
  other.attributes == attributes &&
  other.id == id &&
  other.links == links &&
  other.relationships == relationships;

  @override
  int get hashCode => attributes.hashCode;

  @override
  String toString() =>
  "Instance of BundleId: attributes = $attributes | relationships = $relationships | id = $id | type = $type | links = $links";

}

/// Attributes that describe a Bundle IDs resource.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/attributes.
///
/// [Author] Gillian Buijs.
class BundleIdAttributes {
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

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "name": name,
    "platform": platform.value,
    "seedId": seedId,
  };

  factory BundleIdAttributes.fromJson(dynamic json) {
    final maybePlatform = Optional<String>(json['platform'])
        .map<BundleIdPlatform>(
            (str) => BundleIdPlatform.deserialize(str))
        .orElseThrow(BundleIdException("BundleIdsResponse JSON did not contain required element platform"));

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
class BundleIdRelationships {
  const BundleIdRelationships({
    required this.profiles,
    required this.capabilities,
    required this.app,
  });

  final BundleIdRelationshipsProfiles profiles;
  final BundleIdRelationshipsCapabilities capabilities;
  final BundleIdRelationshipsApp app;

  Map<String, dynamic> toJson() => {
    "profiles": profiles,
    "bundleIdCapabilities": capabilities,
    "app": app,
  };

  factory BundleIdRelationships.fromJson(dynamic json) {
    return BundleIdRelationships(
      profiles: json['profiles'],
      capabilities: BundleIdRelationshipsCapabilities.fromJson(json['bundleIdCapabilities']),
      app: BundleIdRelationshipsApp.fromJson(json['app']),
    );
  }

}

/// The data and links that describe the relationship between the resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships/profiles.
///
/// [Author] Gillian Buijs.
class BundleIdRelationshipsProfiles {

  const BundleIdRelationshipsProfiles({
    required this.data,
    required this.links,
    required this.meta,
  });

  final List<BundleIdRelationshipsProfilesData> data;
  final BundleIdRelationshipsProfilesLinks links;
  final PagingInformation? meta;

  Map<String, dynamic> toJson() => {
    "data": data,
    "links": links,
    "meta": meta,
  };

  factory BundleIdRelationshipsProfiles.fromJson(dynamic json) {
  return BundleIdRelationshipsProfiles(
  data: List.from(json['data'])
      .map((bundleId) => BundleIdRelationshipsProfilesData.fromJson(json['data'])).toList(),
  links: BundleIdRelationshipsProfilesLinks.fromJson(json['links']),
  meta: PagingInformation.fromJson(json['meta']),
  );
  }

  @override
  bool operator ==(Object other) =>
  other is BundleIdRelationshipsProfiles &&
  other.runtimeType == runtimeType &&
  other.data == data &&
  other.links == links &&
  other.meta == meta;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => "Instance of BundleIdRelationshipsProfiles: data = $data | links = $links | meta = $meta";
}


/// The type and ID of a related resource.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships/profiles/data.
///
/// [Author] Gillian Buijs.
class BundleIdRelationshipsProfilesData {
  BundleIdRelationshipsProfilesData(this.id);

  /// (Required)
  final String id;

  /// (Required)
  final String type = "profiles";

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };

  factory BundleIdRelationshipsProfilesData.fromJson(dynamic json) {
    return BundleIdRelationshipsProfilesData(json['id']);
  }

  @override
  bool operator ==(Object other) =>
      other is BundleIdRelationshipsCapabilitiesData &&
          other.runtimeType == runtimeType &&
          other.type == type &&
          other.id == id;

  @override
  int get hashCode => type.hashCode;

  @override
  String toString() =>
      "Instance of BundleIdRelationshipsProfilesData: id = $id | type = $type";
}


/// The links to the related data and the relationship's self-link.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships/profiles/links.
///
/// [Author] Gillian Buijs.
class BundleIdRelationshipsProfilesLinks {
  BundleIdRelationshipsProfilesLinks({required this.related, required this.self});

  /// (Required)
  final String related;

  /// (Required)
  final String self;

  Map<String, dynamic> toJson() => {
    "related": related,
    "self": self,
  };

  factory BundleIdRelationshipsProfilesLinks.fromJson(dynamic json) {
    return BundleIdRelationshipsProfilesLinks(
      related: json['related'],
      self: json['self'],
    );
  }

  @override
  bool operator ==(Object other) =>
      other is BundleIdRelationshipsProfilesLinks &&
          other.runtimeType == runtimeType &&
          other.related == related &&
          other.self == self;

  @override
  int get hashCode => self.hashCode;

  @override
  String toString() =>
      "Instance of BundleIdRelationshipsProfilesLinks: self = $self | related = $related";
}

/// The data and links that describe the relationship between the resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships/bundleidcapabilities.
///
/// [Author] Gillian Buijs.
class BundleIdRelationshipsCapabilities {

  const BundleIdRelationshipsCapabilities({
    required this.data,
    required this.links,
    required this.meta,
  });

  final List<BundleIdRelationshipsCapabilitiesData> data;
  final BundleIdRelationshipsCapabilitiesLinks links;
  final PagingInformation? meta;

  Map<String, dynamic> toJson() => {
    "data": data,
    "links": links,
    "meta": meta,
  };

  factory BundleIdRelationshipsCapabilities.fromJson(dynamic json) {
    return BundleIdRelationshipsCapabilities(
      data: List.from(json['data'])
        .map((bundleId) => BundleIdRelationshipsCapabilitiesData.fromJson(json['data'])).toList(),
      links: BundleIdRelationshipsCapabilitiesLinks.fromJson(json['links']),
      meta: PagingInformation.fromJson(json['meta']),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is BundleIdRelationshipsCapabilities &&
          other.runtimeType == runtimeType &&
          other.data == data &&
          other.links == links &&
          other.meta == meta;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => "Instance of BundleIdRelationshipsCapabilities: data = $data | links = $links | meta = $meta";
}

/// The type and ID of a related resource.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships/bundleidcapabilities/data.
///
/// [Author] Gillian Buijs.
class BundleIdRelationshipsCapabilitiesData {
  BundleIdRelationshipsCapabilitiesData(this.id);

  /// (Required)
  final String id;

  /// (Required)
  final String type = "bundleIdCapabilities";

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };

  factory BundleIdRelationshipsCapabilitiesData.fromJson(dynamic json) {
    return BundleIdRelationshipsCapabilitiesData(json['id']);
  }

  @override
  bool operator ==(Object other) =>
      other is BundleIdRelationshipsCapabilitiesData &&
          other.runtimeType == runtimeType &&
          other.type == type &&
          other.id == id;

  @override
  int get hashCode => type.hashCode;

  @override
  String toString() =>
      "Instance of BundleIdRelationshipsCapabilitiesData: id = $id | type = $type";
}

/// The links to the related data and the relationship's self-link.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships/bundleidcapabilities/links.
///
/// [Author] Gillian Buijs.
class BundleIdRelationshipsCapabilitiesLinks {
  BundleIdRelationshipsCapabilitiesLinks({required this.related, required this.self});

  /// (Required)
  final String related;

  /// (Required)
  final String self;

  Map<String, dynamic> toJson() => {
    "related": related,
    "self": self,
  };

  factory BundleIdRelationshipsCapabilitiesLinks.fromJson(dynamic json) {
    return BundleIdRelationshipsCapabilitiesLinks(
      related: json['related'],
      self: json['self'],
    );
  }

  @override
  bool operator ==(Object other) =>
      other is BundleIdRelationshipsCapabilitiesLinks &&
          other.runtimeType == runtimeType &&
          other.related == related &&
          other.self == self;

  @override
  int get hashCode => self.hashCode;

  @override
  String toString() =>
      "Instance of BundleIdRelationshipsCapabilitieslinks: self = $self | related = $related";
}

/// The data and links that describe the relationship between the resources..
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships/app.
///
/// [Author] Gillian Buijs.
class BundleIdRelationshipsApp {

  const BundleIdRelationshipsApp({
    required this.data,
    required this.links,
  });

  final BundleIdRelationshipsAppData data;
  final BundleIdRelationshipsApplinks links;

  Map<String, dynamic> toJson() => {
    "data": data,
    "links": links
  };

  factory BundleIdRelationshipsApp.fromJson(dynamic json) {
    return BundleIdRelationshipsApp(
      data: BundleIdRelationshipsAppData.fromJson(json['data']),
      links: BundleIdRelationshipsApplinks.fromJson(json['links']),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is BundleIdRelationshipsApp &&
          other.runtimeType == runtimeType &&
          other.data == data &&
          other.links == links;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => "Instance of BundleIdRelationshipsApp: self = $data";
}

/// The type and ID of a related resource.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships/app/data.
///
/// [Author] Gillian Buijs.
class BundleIdRelationshipsAppData {
  BundleIdRelationshipsAppData(this.id);

  /// (Required)
  final String id;

  /// (Required)
  final String type = "apps";

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };

  factory BundleIdRelationshipsAppData.fromJson(dynamic json) {
    return BundleIdRelationshipsAppData(json['id']);
  }

  @override
  bool operator ==(Object other) =>
      other is BundleIdRelationshipsAppData &&
          other.runtimeType == runtimeType &&
          other.type == type &&
          other.id == id;

  @override
  int get hashCode => type.hashCode;

  @override
  String toString() =>
      "Instance of BundleIdRelationshipsAppData: id = $id | type = $type";
}

/// The links to the related data and the relationship's self-link.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/relationships/app/links.
///
/// [Author] Gillian Buijs.
class BundleIdRelationshipsApplinks {
  BundleIdRelationshipsApplinks({required this.related, required this.self});

  /// (Required)
  final String related;

  /// (Required)
  final String self;

  Map<String, dynamic> toJson() => {
    "related": related,
    "self": self,
  };

  factory BundleIdRelationshipsApplinks.fromJson(dynamic json) {
    return BundleIdRelationshipsApplinks(
      related: json['related'],
      self: json['self'],
    );
  }

  @override
  bool operator ==(Object other) =>
      other is BundleIdRelationshipsApplinks &&
          other.runtimeType == runtimeType &&
          other.related == related &&
          other.self == self;

  @override
  int get hashCode => self.hashCode;

  @override
  String toString() =>
      "Instance of BundleIdRelationshipsApplinks: self = $self | related = $related";
}