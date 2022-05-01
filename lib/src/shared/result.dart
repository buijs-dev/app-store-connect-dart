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

import '../utils/http.dart';

/// Wrapper which encapsulates all processing information for a single App Store Connect API request.
///
/// [Author] Gillian Buijs.
class Result<T> {
  /// Private constuctor not meant to be used directly.
  /// Create a Result instance with the no-args constructor instead
  /// and then call the [create] function.
  ///
  /// Example:
  ///
  /// ```
  /// Result<CertificatesResponse>().create(
  ///    warnings: <String>["Timberrrr!"],
  ///    response: response,
  ///    success: (response) => response.statusCode == 200,
  ///    deserialize: (json) => CertificatesResponse.fromJson(json)),
  /// )
  /// ```
  Result._({
    required this.code,
    required this.body,
    required this.isSuccess,
    this.warnings = const [],
    this.value,
  });

  /// No-arg constructor used to set type T.
  /// Call [create] to initialize all fields.
  Result();

  /// Convert the HTTP Response to a Result object.
  Future<Result<T>> create({
    /// The HTTP Response.
    required HttpClientResponse response,

    /// Predicate (function) which takes a HTTP response
    /// and determines if the request was handled successfully.
    required bool Function(HttpClientResponse) success,

    /// Function to deserialize the HTTP response body to a DTO.
    required T Function(String) deserialize,

    /// Any warning occurred during processing.
    List<String> warnings = const [],
  }) async {
    // Convert body stream to String.
    final responseBody = await response.body;

    // Call the predicate function and determine if the request is handled successfully.
    final isSuccess = success(response);

    // Only deserialize if isSuccess is true to avoid running into deserialization issues.
    final value = isSuccess ? deserialize(responseBody) : null;

    return Result<T>._(
      code: response.statusCode,
      body: responseBody,
      isSuccess: isSuccess,
      value: value,
      warnings: warnings,
    );
  }

  /// HTTP response status code.
  late final int code;

  /// HTTP response body.
  late final String body;

  /// Deserialized Response object.
  late final T? value;

  /// Value indicating if the HTTP request is processed successfully.
  late final bool isSuccess;

  /// List of warnings produced by the dart service concerning the handling of the HTTP request and/or response.
  late final List<String> warnings;
}
