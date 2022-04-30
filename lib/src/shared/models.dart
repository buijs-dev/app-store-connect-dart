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

/// Self-links to documents that can contain information for one or more resources.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/documentlinks.
///
/// [Author] Gillian Buijs.
class DocumentLinks extends ResourceLinks {
  DocumentLinks({required String self}) : super(self: self);
}

/// Links related to the response document, including paging links.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/pageddocumentlinks.
///
/// [Author] Gillian Buijs.
class PagedDocumentLinks {

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

  factory PagedDocumentLinks.fromJson(dynamic json) =>
      PagedDocumentLinks(
        first: json['first'],
        next: json['next'],
        self: json['self'],
      );

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
class PagingInformation {

  const PagingInformation({
    required this.paging,
  });

  /// (Required) The paging information details.
  final PagingInformationPaging paging;

  factory PagingInformation.paging({
    required int total,
    required int limit,
  }) => PagingInformation(
    paging: PagingInformationPaging(
      total: total,
      limit: limit,
    ),
  );

  /// Helper to deserialize PagingInformation for responses where it is a nullable element.
  static PagingInformation? fromJson(dynamic json) {

    if(json == null) {
      return json;
    }

    return PagingInformation.paging(
      total: json['paging']['total'],
      limit: json['paging']['limit'],
    );

  }

  Map<String, dynamic> toJson() => { "paging": paging };

}

/// Paging details such as the total number of resources and the per-page limit.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/paginginformation/paging.
///
/// [Author] Gillian Buijs.
class PagingInformationPaging {

  const PagingInformationPaging({
    required this.limit,
    this.total,
  });

  /// (Required) The maximum number of resources to return per page, from 0 to 200.
  final int limit;

  /// The total number of resources matching your request.
  final int? total;

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
class ResourceLinks {

  const ResourceLinks({
    //Such a selfish resource. :-)
    required this.self,
  });

  /// (Required) The link to the resource.
  final String self;

  Map<String, dynamic> toJson() => { "self": self };

}