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

import '../../connect.dart';
import '../utils/nullsafe.dart';
import 'const.dart';
import 'exception.dart';

/// A response that contains a list of Profiles resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/profilesresponse.
///
/// [Author] Gillian Buijs.
class ProfilesResponse with JSON {
  ProfilesResponse({
    required this.data,
    required this.links,
    this.meta,
    this.included,
  });

  /// (Required) The resource data.
  final List<Profile> data;

  /// (Required) Navigational links that include the self-link.
  final PagedDocumentLinks links;

  /// Paging information.
  final PagingInformation? meta;

  /// The requested relationship data.
  ///
  /// Possible types: [BundleId], [Device], [Certificate].
  final dynamic included;

  factory ProfilesResponse.fromJson(String content) {
    final json = jsonDecode(content);

    /// Get required JSON element data or throw [ProfilesException].
    final data = Optional<Iterable<dynamic>>(json['data']).orElseThrow(
      ProfilesException(
        "ProfilesResponse JSON did not contain required element data",
      ),
    );

    /// Get required JSON element links or throw [ProfilesException].
    final links = Optional(json['links']).orElseThrow(
      ProfilesException(
        "ProfilesResponse JSON did not contain required element links",
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

    return ProfilesResponse(
        links: PagedDocumentLinks.fromJson(links),
        meta: meta,
        data: data.map((resource) => Profile.fromJson(resource)).toList(),
        included: json['included']);
  }

  @override
  Map<String, dynamic> toJson() => {
        "data": data,
        "links": links,
        "meta": meta,
      };
}

/// [Author] Gillian Buijs.
class Profile with JSON {
  Profile({
    required this.id,
    required this.links,
    required this.type,
    this.relationships,
    this.attributes,
  });

  /// The resource's attributes.
  final ProfileAttributes? attributes;

  /// Navigational links to related data and included resource types and IDs.
  final ProfileRelationships? relationships;

  /// (Required) The opaque resource ID that uniquely identifies the resource.
  final String id;

  /// (Required) The resource type.
  final String type;

  /// (Required) Navigational links that include the self-link.
  final ResourceLinks links;

  factory Profile.fromJson(dynamic json) {
    /// Get required JSON element id or throw [ProfilesException].
    final id = Optional<dynamic>(json['id']).orElseThrow(
      ProfilesException(
        "Profile JSON response did not contain required element 'id'",
      ),
    );

    /// Get required JSON element type or throw [ProfilesException].
    final type = Optional<dynamic>(json['type']).orElseThrow(
      ProfilesException(
        "Profile JSON response did not contain required element 'type'",
      ),
    );

    /// Get required JSON element links or throw [ProfilesException].
    final links = Optional<dynamic>(json['links']).orElseThrow(
      ProfilesException(
        "Profile JSON response did not contain required element links",
      ),
    );

    return Profile(
      attributes: ProfileAttributes.fromJson(json['attributes']),
      relationships: ProfileRelationships.fromJson(json['relationships']),
      links: DocumentLinks(self: links['self']),
      type: type,
      id: id,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "links": links,
        "attributes": attributes,
        "relationshios": relationships,
      };
}

/// Attributes that describe a Bundle IDs resource.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleid/attributes.
///
/// [Author] Gillian Buijs.
class ProfileAttributes with JSON {
  const ProfileAttributes({
    this.name,
    this.platform,
    this.profileContent,
    this.uuid,
    this.createdDate,
    this.profileState,
    this.profileType,
    this.expirationDate,
  });

  final String? name;
  final BundleIdPlatform? platform;
  final String? profileContent;
  final String? uuid;
  final String? createdDate;
  final ProfileState? profileState;
  final ProfileType? profileType;
  final String? expirationDate;

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "platform": platform?.value,
        "profileContent": profileContent,
        "uuid": uuid,
        "createdDate": createdDate,
        "profileState": profileState,
        "profileType": profileType,
        "expirationDate": expirationDate,
      };

  factory ProfileAttributes.fromJson(dynamic json) {
    /// Get required JSON element platform or throw Exception if value is invalid.
    final maybePlatform =
        Optional<String>(json['platform']).mapOrNull<BundleIdPlatform>(
      (str) => BundleIdPlatform.deserialize(str),
    );

    /// Get required JSON element profileState or throw Exception if value is invalid.
    final maybeProfileState = Optional<String>(json['profileState'])
        .mapOrNull<ProfileState>((str) => ProfileState.deserialize(str));

    /// Get required JSON element profileType or throw Exception if value is invalid.
    final maybeProfileType = Optional<String>(json['profileType'])
        .mapOrNull<ProfileType>((str) => ProfileType.deserialize(str));

    return ProfileAttributes(
      name: json['name'],
      platform: maybePlatform,
      profileContent: json['profileContent'],
      uuid: json['uuid'],
      createdDate: json['createdDate'],
      profileState: maybeProfileState,
      profileType: maybeProfileType,
      expirationDate: json['expirationDate'],
    );
  }
}

/// The relationships you included in the request and those on which you can operate.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/profile/relationships.
///
/// [Author] Gillian Buijs.
class ProfileRelationships with JSON {
  const ProfileRelationships({
    this.certificates,
    this.devices,
    this.bundleId,
  });

  final Relationship? certificates;
  final Relationship? devices;
  final Relationship? bundleId;

  @override
  Map<String, dynamic> toJson() => {
        "certificates": certificates,
        "devices": devices,
        "bundleId": bundleId,
      };

  factory ProfileRelationships.fromJson(dynamic json) {
    /// Get optional JSON element certificates or return null.
    final certificates = Optional<dynamic>(json['certificates'])
        .mapOrNull((json) => Relationship.fromJson(json));

    /// Get optional JSON element bundleId or return null.
    final bundleId = Optional<dynamic>(json['bundleId'])
        .mapOrNull((json) => Relationship.fromJson(json));

    /// Get optional JSON element devices or return null.
    final devices = Optional<dynamic>(json['devices'])
        .mapOrNull((json) => Relationship.fromJson(json));

    return ProfileRelationships(
      certificates: certificates,
      devices: devices,
      bundleId: bundleId,
    );
  }
}
