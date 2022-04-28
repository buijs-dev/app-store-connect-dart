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

/// Factory to create a FileSystemEntity instance which always exists.
///
/// [Author] Gillian Buijs.
class FileFactory {

  FileFactory(dynamic path) {
    FileSystemEntity? fse;

    /// Create a FileSystemEntity instance if the given path is a String.
    if (path is String) {
      ///Return a File if the path contains a "." or a Directory if not.
      fse = path.toString().contains(".") ? File(path).absolute : Directory(path).absolute;
    }

    /// If path is a File or Directory then use it.
    else if (path is File || path is Directory) {
      fse = path.absolute;
    }

    /// The given path is not a String, File or Directory so throw a [FileException] to stop the process.
    else {
      throw FileException(""
          "The given path is not valid. "
          "Please specify an absolute path as String or a File."
          "Received path: '$path'"
      );
    }

    /// Return the fse if it exists
    if (fse!.existsSync()) {
      _wrapper = FileSystemEntityWrapper(fse);
    }

    /// Throw a [FileException] if it does not exist.
    else {
      throw FileException("The given path does not exist. Received path: '$path'");
    }
  }

  late final FileSystemEntityWrapper _wrapper;

  File file() => _wrapper.file();

  Directory folder() => _wrapper.folder();

}

/// [Author] Gillian Buijs.
class FileSystemEntityWrapper {

  FileSystemEntityWrapper(FileSystemEntity entity) {
    _fse = entity;
  }

  late final FileSystemEntity _fse;

  File file() => File(_fse.path);

  Directory folder() => Directory(_fse.path);

}

/// Exception indicating a [File] instance could not be created
/// or a [File] does not exist.
///
/// [Author] Gillian Buijs
class FileException implements Exception {
  FileException(this.cause);

  String cause;

  @override
  String toString() => "FileException with cause: '$cause'";
}