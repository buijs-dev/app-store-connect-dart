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

import '../../appstoreconnect.dart';

/// Basic abstract HTTP client which uses JWT for auth.
///
/// [AppStoreConnect] uses the [AppStoreHttpClient] implementation to communicate
/// with the App Store Connect API.
///
/// A custom [AppStoreClient] implementation can be used for testing
/// to avoid having to use a real developer account.
///
/// [Author] Gillian Buijs.
abstract class AppStoreClient {
  const AppStoreClient();

  Future<HttpClientResponse> get({
    required String uri,
    required String jwt,
  });

  Future<HttpClientResponse> post({
    required String uri,
    required String body,
    required String jwt,
    Map<String, String> headers = const {},
  });

  Future<HttpClientResponse> delete({
    required String uri,
    required String jwt,
  });
}

/// Implementation for the [AppStoreClient].
///
/// [Author] Gillian Buijs.
class AppStoreHttpClient extends AppStoreClient {
  AppStoreHttpClient();

  final _client = HttpClient();

  /// Execute a GET request to the App Store Connect API.
  @override
  Future<HttpClientResponse> get({
    required String uri,
    required String jwt,
    Map<String, String> headers = const {},
  }) async {
    final request = await _client.getUrl(Uri.parse(uri));
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ' + jwt);
    return request.close();
  }

  /// Execute a POST request to the App Store Connect API.
  @override
  Future<HttpClientResponse> post({
    required String uri,
    required String body,
    required String jwt,
    Map<String, String> headers = const {},
  }) async {
    final request = await _client.postUrl(Uri.parse(uri));
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ' + jwt);
    request.write(body);
    return request.close();
  }

  /// Execute a DELETE request to the App Store Connect API.
  @override
  Future<HttpClientResponse> delete({
    required String uri,
    required String jwt,
    Map<String, String> headers = const {},
  }) async {
    final request = await _client.deleteUrl(Uri.parse(uri));
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ' + jwt);
    return request.close();
  }
}
