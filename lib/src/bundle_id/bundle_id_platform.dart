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

/// Strings that represent the operating system intended for the bundle.
///
/// Source: https://developer.apple.com/documentation/appstoreconnectapi/bundleidplatform
///
/// [Author] Gillian Buijs.
enum BundleIdPlatform { ios, macOs }

/// Helper to serialize [BundleIdPLatform] enumeration.
///
/// ios => IOS
/// macOs => MAC_OS
///
/// [Author] Gillian Buijs.
extension BundleIdPlatformExt on BundleIdPlatform {
  String get serialize {
    switch (this) {
      case BundleIdPlatform.ios:
        return "IOS";
      case BundleIdPlatform.macOs:
        return "MAC_OS";
    }
  }
}

/// Helper to deserialize String to [BundleIdPLatform] enumeration.
///
/// Throws [BundleIdPlatformException] if the given value is not valid.
/// Returns [BundleIdPlatform] if value is valid.
///
/// [Author] Gillian Buijs.
class BundleIdPlatformJson {
  static BundleIdPlatform deserialize(String value) {
    if (value == "IOS") {
      return BundleIdPlatform.ios;
    }

    if (value == "MAC_OS") {
      return BundleIdPlatform.macOs;
    }

    throw BundleIdPlatformException(
        "Invalid BundleIdPlatform value: '$value'. ");
  }
}

/// Exception indicating an issue deserializing to [BundleIdPlatform] enumeration.
///
/// [Author] Gillian Buijs.
class BundleIdPlatformException implements Exception {
  BundleIdPlatformException(this.cause);

  String cause;

  @override
  String toString() => "BundleIdPlatformException with cause: '$cause'";
}
