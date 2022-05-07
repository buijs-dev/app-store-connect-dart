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

import 'package:app_store_connect/src/common/common.dart';
import 'package:test/test.dart';

void main() async {

  late final Directory workingDirectory;
  late final File maybeFile;
  late final Directory maybeFolder;

  setUpAll(() {
    // Create a temporary folder to work in.
    workingDirectory = Directory("${Directory.current.absolute.path}${Platform.pathSeparator}foo")..createSync();
    maybeFile = File("${workingDirectory.absolute.path}${Platform.pathSeparator}RUBBISH.txt");
    maybeFolder = Directory("${workingDirectory.absolute.path}${Platform.pathSeparator}RUBBISH");
  });

  test('Verify FileException is thrown if the path is invalid', () async {
    expect(() => FileFactory(true),
        throwsA(predicate((e) => e is FileException && e.cause == "The given path is not valid. "
            "Please specify an absolute path as String or a File."
            "Received path: 'true'")));
  });

  test('Verify that a new File is created if createIfNotExist is true', () async {

    // Check file does not exist
    expect(maybeFile.existsSync(), false);

    // Let FileFactory create it
    final file = FileFactory(maybeFile, createIfNotExists: true).file;

    // Check the file exists
    expect(file.existsSync(), true);

  });

  test('Verify that an existing File is returned as-is', () async {

    final file = FileFactory(maybeFile).file;
    expect(file.existsSync(), true);

  });

  test('Verify that a new Folder is created if createIfNotExist is true', () async {

    // Check file does not exist
    expect(maybeFolder.existsSync(), false);

    // Let FileFactory create it
    final folder = FileFactory(maybeFolder, createIfNotExists: true).folder;

    // Check the file exists
    expect(folder.existsSync(), true);

  });

  test('Verify FileException is thrown if resolve path is null', () async {
    expect(() => FileFactory(maybeFolder).resolve(null),
        throwsA(predicate((e) => e is FileException && e.cause == "The given path is not valid. "
            "Please specify an absolute path as String or a File."
            "Received path: 'null'")));
  });

  test('Verify FileException is thrown if resolve path is invalid', () async {
    expect(() => FileFactory(maybeFolder).resolve(false),
        throwsA(predicate((e) => e is FileException && e.cause == "The given path is not valid. "
            "Please specify an absolute path as String or a File."
            "Received path: 'false'")));
  });

  test('Verify resolve returns a new File link if createIfNotExists is true', () async {
    final file = FileFactory(maybeFolder).resolve("foobar.txt", createIfNotExists: true).file;
    expect(file.existsSync(), true);
  });

  test('Verify resolve returns a new Folder link', () async {
    final folder = FileFactory(maybeFolder).resolve("BARWA", createIfNotExists: true).folder;
    expect(folder.existsSync(), true);
  });

  tearDownAll(() => workingDirectory.deleteSync(recursive: true));

}
