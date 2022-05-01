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

import 'package:http/http.dart' as http;

/// Wrapper for handling the HTTP response returned by the App Store Connect API.
///
/// [Author] Gillian Buijs.
class Result<T> {

  const Result._({
    required this.code,
    required this.body,
    required this.isSuccess,
    this.warnings = const [],
    this.value,
  });

  /// HTTP response status code.
  final int code;

  /// HTTP response body.
  final String body;

  /// Deserialized Response object.
  final T? value;

  /// Value indicating if the HTTP request is processed successfully.
  final bool isSuccess;

  /// List of warnings produced by the dart service concerning the handling of the HTTP request and/or response.
  final List<String> warnings;

  /// Convert the HTTP Response to a Result object.
  factory Result.fromResponse({

    /// The HTTP Response.
    required http.Response response,

    /// Predicate (function) which takes a HTTP response
    /// and determines if the request was handled successfully.
    required bool Function(http.Response) success,

    /// Function to deserialize the HTTP response body to a DTO.
    required T Function(String) deserialize,

    /// Any warning occurred during processing.
    List<String> warnings = const [],
  }) {

    // Call the predicate function and determine if the request is handled successfully.
    final isSuccess = success(response);

    return Result._(
      code: response.statusCode,
      body: response.body,
      isSuccess: isSuccess,
      value: isSuccess ? deserialize(response.body) : null,
      warnings: warnings,
    );

  }

}