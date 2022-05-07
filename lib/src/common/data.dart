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

/// Mixin for JSON serializable classes.
///
/// [Author] Gillian Buijs.
abstract class JSON {
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) =>
      other is JSON &&
          other.runtimeType == runtimeType &&
          other.toJson() == toJson();

  @override
  int get hashCode => toJson().keys.join("=").length;

  @override
  String toString() => "Instance of JSON: ${toJson().entries.join("=")}";
}

/// Parent for const values.
///
/// [Author] Gillian Buijs.
abstract class CONST {
  const CONST(this.value);
  final String value;

  @override
  bool operator ==(Object other) =>
      other is CONST &&
          other.runtimeType == runtimeType &&
          other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => "Instance of CONST: value = $value";
}