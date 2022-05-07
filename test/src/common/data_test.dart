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

import 'package:app_store_connect/src/common/common.dart';
import 'package:test/test.dart';

void main() async {
  test('Verify JSON toString', () async {
    expect(FooJSON({"foo": true}).toString(), "Instance of JSON: {foo: true}");
  });

  test('Verify JSON hashcode', () async {
    /// If both are FOO with the same keys then hashcode is identical.
    expect(FooJSON({"foo": true}).hashCode, FooJSON({"foo": false}).hashCode);

    /// If both are FOO with the different keys then hashcode is not identical.
    expect(
        FooJSON({"foo": true}).hashCode !=
            FooJSON({"foo": true, "bar": "t'challa"}).hashCode,
        true);
  });

  test('Verify JSON equals', () async {
    /// If both are FOO with the same JSON map then equals is true.
    expect(FooJSON({"foo": true}), FooJSON({"foo": true}));

    /// If both are FOO with the different JSON map then equals is false.
    expect(FooJSON({"foo": true}) == FooJSON({"foo": false}), false);
  });

  test('Verify CONST toString', () async {
    expect(FooCONST("CA").toString(), "Instance of CONST: value = CA");
  });

  test('Verify CONST hashcode', () async {
    /// If both are CONST with the same value then hashcode is identical.
    expect(FooCONST("foo").hashCode, FooCONST("foo").hashCode);

    /// If both are CONST with the different values then hashcode is not identical.
    expect(FooCONST("foo").hashCode != FooCONST("nar").hashCode, true);
  });
}

class FooJSON extends JSON {
  FooJSON(this.map);

  final Map<String, dynamic> map;

  @override
  Map<String, dynamic> toJson() => map;
}

class FooCONST extends CONST {
  FooCONST(String value) : super(value);
}

class Bar {}
