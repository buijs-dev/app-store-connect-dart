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

import 'package:app_store_connect/src/cli/arguments.dart';
import 'package:test/test.dart';

void main() async {
  test('Verify splitting of arguments', () async {
    final command = [
      "--issuer-id", "ISSUER_ID",
      "--key-id", "KEY_IDENTIFIER",
      "--private-key", "PRIVATE_KEY",
      "dry-run",
      "nonsense"
    ];

    final arguments = command.toArgs;
    expect(arguments["issuer-id"], "ISSUER_ID");
    expect(arguments["key-id"], "KEY_IDENTIFIER");
    expect(arguments["private-key"], "PRIVATE_KEY");

    final options = arguments["OPTIONS"]?.split(",");
    expect(options?[0], "dry-run");
    expect(options?[1], "nonsense");
  });
}
