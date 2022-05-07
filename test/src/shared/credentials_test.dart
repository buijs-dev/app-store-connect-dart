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

import 'package:app_store_connect/src/service/service_credentials.dart';
import 'package:test/test.dart';

void main() async {
  // Create a temporary folder to work in.
  final workingDirectory = Directory(
      "${Directory.current.absolute.path}${Platform.pathSeparator}foo")
    ..createSync();

  test('Verify apple_keys JSON generation', () async {
    // Assert it actually exists because... you never know.
    expect(workingDirectory.existsSync(), true);

    // Create link to apple_keys.json.
    final keysJson = File(
        "${workingDirectory.absolute.path}${Platform.pathSeparator}apple_keys.json");

    // Assert it does not exist yet.
    expect(keysJson.existsSync(), false);

    // Call method on SUT
    AppStoreCredentials.createTemplate(workingDirectory);

    // Assert the apple_keys.json exists.
    expect(keysJson.existsSync(), true);

    // Read apple_keys.json and remove all whitespaces/linebreaks for easier assertion.
    final content =
        keysJson.readAsStringSync().replaceAll(" ", "").replaceAll("\n", "");

    // Finally assert the template content
    expect(content, json);
  });

  tearDown(() => workingDirectory.deleteSync(recursive: true));
}

final json = """
    {
      "private_key_id": "The private key ID from App Store Connect",
      "private_key": "The private key file (content) from App Store Connect.",
      "issuer_id": "The issuer ID from the API keys page in App Store Connect."
    }"""
    .replaceAll(" ", "")
    .replaceAll("\n", "");
