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
// copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

/// Utility to print templated Strings.
///
/// Example:
///
/// Given a templated String:
/// ```
/// final String foo = """|A multi-line message
///                       |is a message
///                       |that exists of
///                       |multiple lines.
///                       |
///                       |True story"""";
/// ```
///
/// Will produce a multi-line String:
///
/// 'A multi-line message
/// is a message
/// that exists of
/// multiple lines.
///
/// True story'
///
/// [Author] Gillian Buijs.
extension TemplatePrinter on String {
  String format() => replaceAllMapped(
      // Find all '|' char including preceding whitespaces.
      RegExp(r'(\s+?\|)'),
      // Replace them with a single linebreak.
      (_) => "\n").replaceAll("|", "");
}
