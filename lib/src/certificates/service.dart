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
import 'dart:io';

import '../shared/queries.dart';
import '../shared/service.dart';
import '../shared/client.dart';
import '../shared/library.dart';
import '../utils/nullsafe.dart';
import 'const.dart';
import 'request.dart';
import 'response.dart';

List<String> _warnings = [];

/// Service to access the Certificates resource in App Store Connect API.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificates.
///
/// [Author] Gillian Buijs.
class CertificatesService extends Service {
  CertificatesService(AppStoreCredentials credentials, [AppStoreClient? client])
      : super(
          //man -_-
          credentials: credentials,
          path: '/certificates',
          client: client ?? AppStoreHttpClient(),
        );

  /// Retrieve all signing certificates.
  Future<Result<CertificatesResponse>> find(
      [CertificatesQuery Function(CertificatesQuery)? query]) {
    // Create a query if there are parameters.
    // Return null if there are none.
    final queryOrNull = Optional(query).mapOrNull((query) {
      // Params found so create a query.
      return query(CertificatesQuery());
    });

    return _doGet(query: queryOrNull)
        .then((response) => Result<CertificatesResponse>().create(
            warnings: _warnings,
            response: response,
            success: (response) => response.statusCode == 200,
            deserialize: (json) => CertificatesResponse.fromJson(json)))
        .whenComplete(() => _warnings.clear());
  }

  /// Retrieve a signing certificate for given ID.
  Future<Result<CertificateResponse>> findById(String id,
      {CertificateQuery Function(CertificateQuery)? show}) {
    final params = <String>[id];
    final queryOrNull = Optional(show).mapOrNull((show) {
      // Params found so create a query.
      return show(CertificateQuery());
    });

    return _doGet(params: params, query: queryOrNull)
        .then((response) => Result<CertificateResponse>().create(
            warnings: _warnings,
            response: response,
            success: (response) => response.statusCode == 200,
            deserialize: (json) => CertificateResponse.fromJson(json)))
        .whenComplete(() => _warnings.clear());
  }

  /// Create a new signing certificate.
  Future<Result<CertificateResponse>> create({
    required CertificateType certificateType,
    required String csrContent,
  }) {
    final request = CertificateCreateRequest.create(
      certificateType: certificateType,
      csrContent: csrContent,
    );

    return _doPost(request)
        .then((response) => Result<CertificateResponse>().create(
            warnings: _warnings,
            response: response,
            success: (response) => response.statusCode == 201,
            deserialize: (json) => CertificateResponse.fromJson(json)))
        .whenComplete(() => _warnings.clear());
  }

  /// Revoke a signing certificate for given ID.
  ///
  /// Return [bool].
  Future<Result<bool>> revokeById(id) {
    return _doDelete(params: [id])
        .then((response) => Result<bool>().create(
            warnings: _warnings,
            response: response,
            success: (response) => response.statusCode == 204,
            deserialize: (json) => response.statusCode == 204 ? true : false))
        .whenComplete(() => _warnings.clear());
  }

  /// Execute a GET with specified query and/or path parameters and return the response body as String.
  Future<HttpClientResponse> _doGet(
      {CertificateQuery? query, List<String>? params}) {
    if (query != null) super.query = query._createQueryMap;
    if (params != null) super.params = params;
    return super.doGet;
  }

  /// Execute a POST with specified query and/or path parameters and return the response body as String.
  Future<HttpClientResponse> _doPost(CertificateCreateRequest request) {
    return super.doPost(jsonEncode(request));
  }

  /// Execute a DELETE with specified path parameters.
  ///
  /// Return true if deleted or false if not.
  Future<HttpClientResponse> _doDelete({List<String>? params}) {
    if (params != null) super.params = params;
    return super.doDelete;
  }
}

/// Helper to construct query params for finding Certificates with [CertificatesService.find].
///
/// [Author] Gillian Buijs.
class CertificatesQuery extends CertificateQuery with QueryLimit {
  /// Only return Certificates which matches an ID specified in this list.
  List<String> filterId = [];

  /// Only return Certificates which matches a serialNumber specified in this list.
  List<String> filterSerialNumber = [];

  /// Only return Certificates which matches a displayName specified in this list.
  List<String> filterDisplayName = [];

  /// Sort the result list by specified fields.
  final List<_CertificatesSort> _sort = [];

  /// Sort the results by field CertificateType in ascending order.
  void get sortByCertificateTypeAsc {
    _sort.add(_CertificatesSort.certificateTypeAsc);
  }

  /// Sort the results by field CertificateType in descending order.
  void get sortByCertificateTypeDesc {
    _sort.add(_CertificatesSort.certificateTypeDesc);
  }

  /// Sort the results by field DisplayName in ascending order.
  void get sortByDisplayNameAsc {
    _sort.add(_CertificatesSort.displayNameAsc);
  }

  /// Sort the results by field DisplayName in descending order.
  void get sortByDisplayNameDesc {
    _sort.add(_CertificatesSort.displayNameDesc);
  }

  /// Sort the results by field ID in ascending order.
  void get sortByIdAsc {
    _sort.add(_CertificatesSort.idAsc);
  }

  /// Sort the results by field ID in descending order.
  void get sortByIdDesc {
    _sort.add(_CertificatesSort.idDesc);
  }

  /// Sort the results by field SerialNumber in ascending order.
  void get sortBySerialNumberAsc {
    _sort.add(_CertificatesSort.serialNumberAsc);
  }

  /// Sort the results by field SerialNumber in descending order.
  void get sortBySerialNumberDesc {
    _sort.add(_CertificatesSort.serialNumberDesc);
  }

  /// Create a map containing the query parameter names and comma separated values.
  ///
  /// Example:
  ///
  /// Given a filterId list containing ["foo", "bar"]
  /// will return key 'filter[id]=foo,bar'.
  ///
  /// Returns Map<String,String> for all specified query parameters.
  @override
  Map<String, String> get _createQueryMap {
    final map = <String, String>{};

    if (filterId.isNotEmpty) {
      map.putIfAbsent("filter[id]", () => filterId.join(','));
    }

    if (filterDisplayName.isNotEmpty) {
      map.putIfAbsent(
        "filter[displayName]",
        () => filterDisplayName.join(','),
      );
    }

    if (filterSerialNumber.isNotEmpty) {
      map.putIfAbsent(
        "filter[serialNumber]",
        () => filterSerialNumber.join(','),
      );
    }

    if (_sort.isNotEmpty) {
      map.putIfAbsent("sort", () => _sort.map((e) => e.serialize).join(','));
    }

    if (limit != null) {
      map.putIfAbsent("limit", () => "$limit");
    }

    if (_fields.isNotEmpty) {
      map.putIfAbsent(
        "fields[certificates]",
        () => _fields.map((e) => e.name).join(','),
      );
    }

    return map;
  }
}

/// Helper to construct query params for 'fields' filter only.
///
/// [Author] Gillian Buijs.
class CertificateQuery {
  /// Filter which fields of the [CertificateAttributes] should be returned by the App Store Connect API.
  ///
  /// If no fields are specified then all are returned.
  final List<_CertificatesFields> _fields = [];

  /// Configure the query to show certificatesContent field.
  void get showCertificateContent {
    _fields.add(_CertificatesFields.certificateContent);
  }

  /// Configure the query to show certificateType field.
  void get showCertificateType {
    _fields.add(_CertificatesFields.certificateType);
  }

  /// Configure the query to show expirationDate field.
  void get showExpirationDate {
    _fields.add(_CertificatesFields.expirationDate);
  }

  /// Configure the query to show csrContent field.
  void get showCsrContent {
    _fields.add(_CertificatesFields.csrContent);
  }

  /// Configure the query to show displayName field.
  void get showDisplayName {
    _fields.add(_CertificatesFields.displayName);
  }

  /// Configure the query to show name field.
  void get showName {
    _fields.add(_CertificatesFields.name);
  }

  /// Configure the query to show platform field.
  void get showPlatform {
    _fields.add(_CertificatesFields.platform);
  }

  /// Configure the query to show serialNumber field.
  void get showSerialNumber {
    _fields.add(_CertificatesFields.serialNumber);
  }

  /// Create a map containing the query parameter names and comma separated values.
  ///
  /// Example:
  ///
  /// Given a _fields list containing [_CertificatesFields.serialNumber]
  /// will return key 'fields[certificates]=serialNumber'.
  ///
  /// Returns Map<String,String> for all specified query parameters.
  Map<String, String> get _createQueryMap {
    final map = <String, String>{};

    if (_fields.isNotEmpty) {
      map.putIfAbsent(
        "fields[certificates]",
        () => _fields.map((e) => e.name).join(','),
      );
    }

    return map;
  }
}

/// JSON fields of the [CertificatesResponse] and [CertificateResponse] that can be filtered and sorted.
///
/// [Author] Gillian Buijs.
enum _CertificatesFields {
  certificateContent,
  certificateType,
  csrContent,
  displayName,
  expirationDate,
  name,
  platform,
  serialNumber
}

/// Query parameters used to sort the [CertificatesResponse].
///
/// [Author] Gillian Buijs.
enum _CertificatesSort {
  certificateTypeAsc,
  certificateTypeDesc,
  displayNameAsc,
  displayNameDesc,
  idAsc,
  idDesc,
  serialNumberAsc,
  serialNumberDesc,
}

/// Helper to serialize [_CertificatesSort] enumeration.
///
/// [Author] Gillian Buijs.
extension _CertificatesSortExt on _CertificatesSort {
  String get serialize {
    switch (this) {
      case _CertificatesSort.certificateTypeAsc:
        return "certificateType";
      case _CertificatesSort.certificateTypeDesc:
        return "-certificateType";
      case _CertificatesSort.displayNameAsc:
        return "displayName";
      case _CertificatesSort.displayNameDesc:
        return "-displayName";
      case _CertificatesSort.idAsc:
        return "id";
      case _CertificatesSort.idDesc:
        return "-id";
      case _CertificatesSort.serialNumberAsc:
        return "serialNumber";
      case _CertificatesSort.serialNumberDesc:
        return "-serialNumber";
    }
  }
}
