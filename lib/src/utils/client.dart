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
import 'package:appstoreconnect/appstoreconnect.dart';
import 'package:http/http.dart' as http;

const baseUri = 'https://api.appstoreconnect.apple.com/v1';
const profilesUri = baseUri + '/profiles';
const buildsUri = baseUri + '/builds';
const bundleIdsUri = baseUri + '/bundleIds';
const certificatesUri = baseUri + '/certificates';

/// Basic abstract HTTP client which uses JWT for auth.
///
/// [AppStoreConnect] uses the [AppleClient] implementation to communicate
/// with the App Store Connect API.
///
/// A custom [AbstractAppleClient] implementation can be used for testing
/// to avoid having to use a real developer account.
///
/// [Author] Gillian Buijs.
abstract class AbstractAppleClient {

  const AbstractAppleClient();

  Future<http.Response> get({
    required String uri,
    required String jwt,
  });

  Future<http.Response> post({
    required String uri,
    required String body,
    required String jwt,
    Map<String, String> headers = const {},
  });

}

/// Implementation for the [AbstractAppleClient].
///
/// [Author] Gillian Buijs.
class AppleClient extends AbstractAppleClient {

  const AppleClient();

  @override
  /// Execute a GET request to the App Store Connect API.
  Future<http.Response> get({
    required String uri,
    required String jwt,
    Map<String, String> headers = const {},
  }) async {

    final endpoint = Uri.parse(uri);

    var response = await http.get(
        Uri.parse(uri),
        headers: _createHeaders(jwt)..addAll(headers),
    );

    return _verifyResponse(response, endpoint, 200);

  }

  @override
  /// Execute a POST request to the App Store Connect API.
  Future<http.Response> post({
    required String uri,
    required String body,
    required String jwt,
    Map<String, String> headers = const {},
  }) async {

    final endpoint = Uri.parse(uri);

    final response = await http.post(
      Uri.parse(uri),
      body: body,
      headers: _createHeaders(jwt)..addAll(headers),
    );

    return _verifyResponse(response, endpoint, 201);

  }

  /// Create a headers map with the JWT token.
  Map<String, String> _createHeaders(String jwt) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + jwt
  };

  /// Verify if the response code is as expected.
  ///
  /// Throws [HttpException] if the given code is not as expected.
  /// Returns [http.Response] if the given code is as expected.
  http.Response _verifyResponse(http.Response response, Uri uri, int code) {

    if (response.statusCode == code) {
      return response;
    }

    throw HttpException(
      "Http request returned status code ${response.statusCode.toString()}",
      uri: uri,
    );

  }

}