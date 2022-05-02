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

import 'strings.dart';

///Utility for CLI logging. Because colours make life more beautiful. \0/
///
///[Author] Gillian Buijs.
class Echo {

  static const red = "\x1B[31m";
  static const green = "\x1B[32m";
  static const yellow = "\x1B[33m";

  static info(String message) => print('${yellow}APP STORE CLIENT: $message'.format);

  static success(String message) => print('${green}APP STORE CLIENT: $message'.format);

  static warning(String message) => print('${red}APP STORE CLIENT: $message'.format);

  static hello(String version) => print('''$green
  ════════════════════════════════════════════
     APP STORE CLIENT (v$version)                               
  ════════════════════════════════════════════
  ''');

}