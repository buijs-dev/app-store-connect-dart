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

import 'package:app_store_client/src/shared/credentials.dart';
import 'package:app_store_client/src/commandline/library.dart';
import 'package:app_store_client/src/utils/strings.dart';

const _link =
    "https://developer.apple.com/documentation/appstoreconnectapi/creating_api_keys_for_app_store_connect_api";

/// Generate a new apple_keys.json template in the working directory.
///
///[Author] Gillian Buijs.
Future<void> main(List<String> args) async {
  Echo.hello("1.0.0");
  // Create a temporary folder to work in.
  final workingDirectory = Directory.current;

  // Create link to apple_keys.json.
  final keysJson = File(
      "${workingDirectory.absolute.path}${Platform.pathSeparator}apple_keys.json");

  // Assert it does not exist yet.
  if (keysJson.existsSync()) {
    Echo.warning(
      "File already exists: "
      "'${keysJson.absolute.path}'. "
      "Delete it first if you want to generate a new template.",
    );
  } else {
    // Create the apple_keys.json file.
    AppStoreCredentials.createTemplate(workingDirectory);

    // Check if the file actually exists.
    if (keysJson.existsSync()) {
      final message = """ |File created: '${keysJson.absolute.path}'.
                          |
                          |For how to create API keys see: '$_link'.""";
      Echo.success(message.format);
    } else {
      Echo.warning("Failed to create file: '${keysJson.absolute.path}'...");
    }
  }
}
