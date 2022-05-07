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

import 'package:app_store_client/src/cli/bundles.dart';
import 'package:app_store_client/src/cli/logging.dart' as echo;

/// Register a new Bundle ID.
///
///[Author] Gillian Buijs.
Future<void> main(List<String> args) async {
  echo.hello("1.0.0");

  deleteBundleId(args).then((response) {
    for (var msg in response.warnings) {
      echo.warning(msg);
    }

    for (var msg in response.info) {
      echo.info(msg);
    }

    if (!response.isSuccess) {
      echo.warning("Something went wrong deleting a Bundle ID.");
    } else {
      echo.info("Bundle ID deleted: ${response.id}");
    }
  });
}
