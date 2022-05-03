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

///[Author] Gillian Buijs.
class Arguments {
  /// AppStoreCredentials command-line keys.
  static const issuerId = "issuer-id";
  static const keyId = "key-id";
  static const privateKey = "private-key";
  static const appleKeysFile = "key-file";

  /// AppStoreCredentials environment variables.
  static const issuerIdEnv = "APP_STORE_CONNECT_ISSUER_ID";
  static const keyIdEnv = "APP_STORE_CONNECT_KEY_IDENTIFIER";
  static const privateKeyEnv = "APP_STORE_CONNECT_PRIVATE_KEY";

  /// Certificates command-line keys.
  static const filterId = "id";
  static const filterSerialNumber = "serial-number";
  static const filterDisplayName = "display-name";
}


///Extension to convert a list of arguments to a map.
///
///Arguments list is expected to be as follows: --foo bar --zeta store some-value some-other-value
///
///Returns map of {"foo": "bar", "zeta": "store", "OPTIONS": "some-value,some-other-value" }
///[Author] Gillian Buijs.
extension ArgumentSplitter on List<String> {
  Map<String, String> get toArgs {

    final temp = <String, String>{};
    for (int i = 0; i < length; i++) {
      final key = this[i];

      // Process key as '--key value'.
      if (key.startsWith("--")) {
        final keyValue = key
            .substring(
          // remove '--' prefix
            key.lastIndexOf("--") + 2);
        // // split 'key value' to [key, value]
        //     .split(" ");

        // Add key with value to temp map.
        i += 1;
        temp[keyValue] = this[i];
      }

      // Process key as standalone 'some-value'.
      else {
        // Check if there already is a saved option.
        if (temp.containsKey("OPTIONS")) {
          // Add the key to the comma separated value e.g.: 'OPTIONS=value1,value2,value3'
          temp["OPTIONS"] = "${temp["OPTIONS"]},$key";
        } else {
          // Create a new 'OPTIONS' key and store the value.
          temp["OPTIONS"] = key;
        }
      }
    }

    return temp;
  }
}
