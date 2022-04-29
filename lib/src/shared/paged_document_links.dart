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