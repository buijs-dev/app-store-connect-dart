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

import 'dart:io';

import '../shared/credentials.dart';
import '../shared/client.dart';

/// Parent for all App Store Connect API Resource Services.
///
/// [Author] Gillian Buijs.
class Service {
  Service({
    required this.credentials,
    required this.path,
    required this.client,
  });

  /// Credentials used to create a JSON web token for authenticating.
  final AppStoreCredentials credentials;

  /// Resource path which is appended to the base App Store Connect API endpoint.
  final String path;

  /// Client which communicates with the App Store Connect API.
  ///
  /// Defaults to [AppStoreHttpClient].
  final AppStoreClient client;

  /// Query parameters.
  var query = <String, String>{};

  /// Path parameters
  var params = <String>[];

  /// Resource URI e.g. base endpoint + path + path parameters + query parameters.
  String get _uri =>
      "https://api.appstoreconnect.apple.com/v1$path$_printParams$_printQuery";

  /// Print the query params or return an empty String if there are none.
  String get _printQuery {
    var printed = "?";

    // Join the map to a single query String.
    final keys = query.keys.toList();
    final values = query.values.toList();

    for (int i = 0; i < keys.length; i++) {
      if (i != 0) printed += "&";
      printed += "${keys[i]}=${values[i]}";
    }

    // Clear the query for the next requests.
    query.clear();

    // If there are no query params then return an empty String.
    return printed == "?" ? "" : printed;
  }

  /// Print the path params or return an empty String if there are none.
  String get _printParams {
    var printed = "";

    // Join the params to a single path String.
    for (var param in params) {
      printed += "/$param";
    }

    // Clear the params for the next requests.
    params.clear();

    return printed;
  }

  /// Execute a GET request to App Store Connect API.
  Future<HttpClientResponse> get doGet async => client.get(
        uri: _uri,
        jwt: credentials.jsonWebToken,
      );

  /// Execute a POST request to App Store Connect API.
  Future<HttpClientResponse> doPost(String body) async => client.post(
        uri: _uri,
        jwt: credentials.jsonWebToken,
        body: body,
      );

  /// Execute a POST request to App Store Connect API.
  Future<HttpClientResponse> doPatch(String body) async => client.patch(
        uri: _uri,
        jwt: credentials.jsonWebToken,
        body: body,
      );

  /// Execute a DELETE request to App Store Connect API.
  Future<HttpClientResponse> get doDelete async => client.delete(
        uri: _uri,
        jwt: credentials.jsonWebToken,
      );
}
