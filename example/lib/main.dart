// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

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

/// Import the appstoreconnect library.
import 'dart:io';

import 'package:appstoreconnect/appstoreconnect.dart';

/// Example of creating an AppStoreConnect instance.
void main(List<String> arguments) async {

  /// Create an AppleCredentials instance.
  ///
  /// Read from JSON file given the file is named 'apple_keys.json'
  /// and stored in the current folder.
  final pathToJson =
      "${Directory.current.path}apple_keys.json";
  final credentials = AppStoreCredentials.fromFile(pathToJson);

  /// Create an AppStoreConnect instance.
  final service = AppStoreConnect(credentials);

  /// Now you can use the service to communicate with App Store Connect.
  ///
  /// For example: Retrieve all certificates:
  await service.certificates.find().then((certificates) => print(certificates));

  /// Or execute a query to find a specific Certificate:
  await service.certificates
      .find((_) => _
        ..filterId = ["1234NOIDEA"]
        ..filterSerialNumber = ["FOOBAR123"]
        ..filterDisplayName = ["Beautiful Display"]
        ..limit = 1)
      .then((certificate) => print(certificate));

  /// Limit the response data returned:
  await service.certificates
      .find((_) => _
        ..showDisplayName
        ..showCsrContent)
      .then((certificates) => print(certificates));

  /// Find by ID:
  await service.certificates.findById("1234NOIDEA");

  /// Find by ID with limited response data returned:
  await service.certificates.findById("1234NOIDEA",
      show: (_) => _
        ..showDisplayName
        ..showCsrContent
        ..showName);
}
