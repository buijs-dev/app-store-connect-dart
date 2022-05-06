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

import '../utils/library.dart';

/// Mixin for JSON serializable classes.
///
/// [Author] Gillian Buijs.
abstract class JSON {
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) =>
      other is JSON &&
      other.runtimeType == runtimeType &&
      other.toJson() == toJson();

  @override
  int get hashCode => toJson().keys.join("=").length;

  @override
  String toString() => "Instance of JSON: ${toJson().entries.join("=")}";
}

/// Parent for const values.
///
/// [Author] Gillian Buijs.
abstract class CONST {
  const CONST(this.value);
  final String value;

  @override
  bool operator ==(Object other) =>
      other is CONST &&
      other.runtimeType == runtimeType &&
      other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => "Instance of CONST: value = $value";
}

/// The data and links that describe the relationship between the resources.
///
/// [Author] Gillian Buijs.
class Relationship with JSON {
  const Relationship({
    this.data,
    this.links,
    this.meta,
  });

  final List<RelationshipData>? data;
  final RelationshipLinks? links;
  final PagingInformation? meta;

  @override
  Map<String, dynamic> toJson() => {
        "data": data,
        "links": links,
        "meta": meta,
      };

  factory Relationship.fromJson(dynamic json) {
    final data = Optional<dynamic>(json['data']).mapOrNull((json) =>
        List.from(json).map((e) => RelationshipData.fromJson(e)).toList());

    final links = Optional<dynamic>(json['links'])
        .mapOrNull((json) => RelationshipLinks.fromJson(json));

    final meta = Optional<dynamic>(json['meta'])
        .map((json) => json['paging'])
        .mapOrNull((json) => PagingInformation.paging(
            total: json['total'], limit: json['limit']));

    return Relationship(
      data: data,
      links: links,
      meta: meta,
    );
  }
}

/// The data and links that describe the relationship between the resources.
///
/// [Author] Gillian Buijs.
class RelationshipData with JSON {
  const RelationshipData({
    required this.id,
    required this.type,
  });

  final String id;
  final String type;

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };

  factory RelationshipData.fromJson(dynamic json) {
    return RelationshipData(
      id: json['id'],
      type: json['type'],
    );
  }
}

/// The links to the related data and the relationship's self-link..
///
/// [Author] Gillian Buijs.
class RelationshipLinks with JSON {
  const RelationshipLinks({
    required this.related,
    required this.self,
  });

  final String related;
  final String self;

  @override
  Map<String, dynamic> toJson() => {
        "related": related,
        "self": self,
      };

  factory RelationshipLinks.fromJson(dynamic json) {
    return RelationshipLinks(
      related: json['related'],
      self: json['self'],
    );
  }
}

/// Self-links to documents that can contain information for one or more resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/documentlinks.
///
/// [Author] Gillian Buijs.
class DocumentLinks extends ResourceLinks with JSON {
  DocumentLinks({required String self}) : super(self);

  @override
  Map<String, dynamic> toJson() => {
        "self": self,
      };
}

/// Links related to the response document, including paging links.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/pageddocumentlinks.
///
/// [Author] Gillian Buijs.
class PagedDocumentLinks with JSON {
  const PagedDocumentLinks({
    required this.self,
    this.first,
    this.next,
  });

  /// (Required) The link that produced the current document.
  final String self;

  /// The link to the first page of documents.
  final String? first;

  /// The link to the next page of documents.
  final String? next;

  factory PagedDocumentLinks.fromJson(dynamic json) => PagedDocumentLinks(
        first: json['first'],
        next: json['next'],
        self: json['self'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "first": first,
        "next": next,
        "self": self,
      };
}

/// Paging information for data responses.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/paginginformation.
///
/// [Author] Gillian Buijs.
class PagingInformation with JSON {
  const PagingInformation(this.paging);

  /// (Required) The paging information details.
  final PagingInformationPaging paging;

  factory PagingInformation.paging({
    required int total,
    required int limit,
  }) =>
      PagingInformation(
        PagingInformationPaging(
          total: total,
          limit: limit,
        ),
      );

  @override
  Map<String, dynamic> toJson() => {"paging": paging};
}

/// Paging details such as the total number of resources and the per-page limit.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/paginginformation/paging.
///
/// [Author] Gillian Buijs.
class PagingInformationPaging with JSON {
  const PagingInformationPaging({
    required this.limit,
    this.total,
  });

  /// (Required) The maximum number of resources to return per page, from 0 to 200.
  final int limit;

  /// The total number of resources matching your request.
  final int? total;

  @override
  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
      };
}

/// Self-links to requested resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/resourcelinks.
///
/// [Author] Gillian Buijs.
class ResourceLinks with JSON {
  //Such a selfish resource. :-)
  const ResourceLinks(this.self);

  /// (Required) The link to the resource.
  final String self;

  @override
  Map<String, dynamic> toJson() => {"self": self};
}

/// Exception indicating an issue communicating with the App Store Connect API resources.
///
/// [Author] Gillian Buijs.
class AppStoreResourceException implements Exception {
  AppStoreResourceException(this.cause);

  String cause;

  @override
  String toString() =>
      "AppStoreResourceException with cause: '${cause.format}'";
}
