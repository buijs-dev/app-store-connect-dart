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

import 'package:appstoreconnect/appstoreconnect.dart';
import 'package:http/http.dart' as http;

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

  Future<http.Response> delete({
    required String uri,
    required String jwt,
  });

}

/// Implementation for the [AppStoreClient].
///
/// [Author] Gillian Buijs.
class AppStoreHttpClient extends AppStoreClient {

  const AppStoreHttpClient();

  @override
  /// Execute a GET request to the App Store Connect API.
  Future<http.Response> get({
    required String uri,
    required String jwt,
    Map<String, String> headers = const {},
  })  => http.get(Uri.parse(uri), headers: headers.add(jwt));

  @override
  /// Execute a POST request to the App Store Connect API.
  Future<http.Response> post({
    required String uri,
    required String body,
    required String jwt,
    Map<String, String> headers = const {},
  }) => http.post(Uri.parse(uri), body: body, headers: headers.add(jwt));

  @override
  /// Execute a DELETE request to the App Store Connect API.
  Future<http.Response> delete({
    required String uri,
    required String jwt,
    Map<String, String> headers = const {},
  }) => http.delete(Uri.parse(uri), headers: headers.add(jwt));

}

extension _JWT on Map<String, String> {
  Map<String, String> add(String token) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + token
  }..addAll(this);
}