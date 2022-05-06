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

import '../../connect.dart';

import 'exception.dart';

/// Strings that represent the operating system intended for the bundle.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleidplatform
///
/// [Author] Gillian Buijs.
class BundleIdPlatform extends CONST {
  const BundleIdPlatform(String value) : super(value);

  static const ios = BundleIdPlatform("IOS");
  static const macOs = BundleIdPlatform("MAC_OS");
  static const universtal = BundleIdPlatform("UNIVERSAL");

  static List<BundleIdPlatform> get values => [ios, macOs, universtal];

  /// Helper to deserialize String to [BundleIdPlatform] enumeration.
  ///
  /// Throws [BundleIdException] if the given value is not valid.
  /// Returns [BundleIdPlatform] if value is valid.
  ///
  /// [Author] Gillian Buijs.
  factory BundleIdPlatform.deserialize(String value) {
    return BundleIdPlatform.values.firstWhere(
      (type) => type.value == value,
      orElse: () => throw BundleIdException(
        "Invalid BundleIdPlatform value: '$value'.",
      ),
    );
  }
}
