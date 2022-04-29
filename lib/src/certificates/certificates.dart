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

library certificates;

import 'package:logger/logger.dart';

import '../utils/client.dart';
import '../base/base_service.dart';
import '../credentials.dart';
import 'certificate_fields.dart';
import 'certificates_response.dart';
import 'certificate_sort.dart';

final _log = Logger();

/// Wrapper which creates valid requests and uses an [AppleClient] to execute it.
late final BaseService _base;

/// Service to access the Certificates resource in App Store Connect API.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/certificates.
///
/// [Author] Gillian Buijs.
class CertificatesService {

  CertificatesService(AppleCredentials credentials, [AppleClient? client]) {
    _base = BaseService(
      credentials: credentials,
      path: '/certificates',
      client: client ?? const HttpAppleClient(),
    );
  }

  /// Retrieve all signing certificates.
  Future<CertificatesResponse> get find async => await _base.doGet
      .then((response) => response.body)
      .then((json) => CertificatesResponse.fromJson(json));

  /// Retrieve signing certificates that match the specified query.
  Future<CertificatesResponse> findByQuery(CertificatesQuery query) async =>
      _doGetWithQuery(this, query);

}

/// Helper to construct query params for finding Certificates with [CertificatesService.find].
///
/// [Author] Gillian Buijs.
class CertificatesQuery  {

  /// Filter which fields of the [CertificateAttributes] should be returned by the App Store Connect API.
  ///
  /// If no fields are specified then all are returned.
  final List<CertificatesFields> _fields = [];

  /// Only return Certificates which matches an ID specified in this list.
  List<String> filterId = [];

  /// Only return Certificates which matches a serialNumber specified in this list.
  List<String> filterSerialNumber = [];

  /// Only return Certificates which matches a displayName specified in this list.
  List<String> filterDisplayName = [];

  /// Sort the result list by specified fields.
  final List<CertificatesSort> _sort = [];

  /// Limit the number of certificates returned.
  ///
  /// Max limit is 200.
  int? _limit;

  set limit(int limit) {

    /// If limit is less than 1 then log a warning and set the limit to 1.
    if(limit < 1) {
      _log.w("Specified limit is invalid: $limit");
      _log.w("Why do you want to see less than 1 certificate!?");
      _log.w("Setting limit to: '1'");
      _limit = 1;
    }

    /// If the limit is more than 200 then log a warning and set to max value.
    else if(limit > 200) {
      _log.w("Specified limit exceeds the maximum value: $limit");
      _log.w("Setting limit to maximum value: '200'");
      _limit = 200;
    }

    /// Set the limit because the requested value is within acceptable range.
    else {
      _limit = limit;
    }

  }

  /// Configure the query to show certificatesContent field.
  void get showCertificateContent {
    _fields.add(CertificatesFields.certificateContent);
  }

  /// Configure the query to show certificateType field.
  void get showCertificateType {
    _fields.add(CertificatesFields.certificateType);
  }

  /// Configure the query to show expirationDate field.
  void get showExpirationDate {
    _fields.add(CertificatesFields.expirationDate);
  }

  /// Configure the query to show csrContent field.
  void get showCsrContent {
    _fields.add(CertificatesFields.csrContent);
  }

  /// Configure the query to show displayName field.
  void get showDisplayName {
    _fields.add(CertificatesFields.displayName);
  }

  /// Configure the query to show name field.
  void get showName {
    _fields.add(CertificatesFields.name);
  }

  /// Configure the query to show platform field.
  void get showPlatform {
    _fields.add(CertificatesFields.platform);
  }

  /// Configure the query to show serialNumber field.
  void get showSerialNumber {
    _fields.add(CertificatesFields.serialNumber);
  }

  /// Sort the results by field CertificateType in ascending order.
  void get sortByCertificateTypeAsc {
    _sort.add(CertificatesSort.certificateTypeAsc);
  }

  /// Sort the results by field CertificateType in descending order.
  void get sortByCertificateTypeDesc {
    _sort.add(CertificatesSort.certificateTypeDesc);
  }

  /// Sort the results by field DisplayName in ascending order.
  void get sortByDisplayNameAsc {
    _sort.add(CertificatesSort.displayNameAsc);
  }

  /// Sort the results by field DisplayName in descending order.
  void get sortByDisplayNameDesc {
    _sort.add(CertificatesSort.displayNameDesc);
  }

  /// Sort the results by field ID in ascending order.
  void get sortByIdAsc {
    _sort.add(CertificatesSort.idAsc);
  }

  /// Sort the results by field ID in descending order.
  void get sortByIdDesc {
    _sort.add(CertificatesSort.idDesc);
  }

  /// Sort the results by field SerialNumber in ascending order.
  void get sortBySerialNumberAsc {
    _sort.add(CertificatesSort.serialNumberAsc);
  }

  /// Sort the results by field SerialNumber in descending order.
  void get sortBySerialNumberDesc {
    _sort.add(CertificatesSort.serialNumberDesc);
  }

  /// Create a map containing the query parameter names and comma separated values.
  ///
  /// Example:
  ///
  /// Given a filterId list containing ["foo", "bar"]
  /// will return key 'filter[id]=foo,bar'.
  ///
  /// Returns Map<String,String> for all specified query parameters.
  Map<String, String> get _createQueryMap {
    final map = <String, String>{};

    if(_fields.isNotEmpty) {
      map.putIfAbsent("fields[certificates]", () => _fields.join(','));
    }

    if(filterId.isNotEmpty) {
      map.putIfAbsent("filter[id]", () => filterId.join(','));
    }

    if(filterDisplayName.isNotEmpty) {
      map.putIfAbsent("filter[displayName]", () => filterDisplayName.join(','));
    }

    if(filterSerialNumber.isNotEmpty) {
      map.putIfAbsent("filter[serialNumber]", () => filterSerialNumber.join(','));
    }

    if(_sort.isNotEmpty) {
      map.putIfAbsent("sort", () => _sort.map((e) => e.serialize).join(','));
    }

    if(_limit != null) {
      map.putIfAbsent("limit", () => "$_limit");
    }

    return map;
  }

}

/// Execute a GET with specified query parameters and return a [CertificatesResponse].
Future<CertificatesResponse> _doGetWithQuery(CertificatesService service, CertificatesQuery query) async {
  _base.query = query._createQueryMap;
  return await service.find;
}