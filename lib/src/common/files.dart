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

final String _s = Platform.pathSeparator;

/// Factory to create a FileSystemEntity instance which always exists.
///
/// [Author] Gillian Buijs.
class FileFactory {
  FileFactory(dynamic path, {createIfNotExists = false}) {
    FileSystemEntity? fse;

    /// If path is a File then use it.
    if (path is File) {
      fse = File(path.absolute.path.replaceAll("/", _s));
    }

    /// If path is a Directory then use it.
    if (path is Directory) {
      fse = Directory(path.absolute.path.replaceAll("/", _s));
    }

    /// Create a FileSystemEntity instance if the given path is a String.
    else if (path is String) {
      fse = _absolutePath(path.replaceAll("/", _s));
    }

    /// The given path is not a String, File or Directory so throw a [FileException] to stop the process.
    if (fse == null) invalidPath(path);

    /// Save the path as String for resolving relative paths later.
    _absolutePathString = fse!.absolute.path;

    /// Set the fse if it exists
    if (fse.existsSync()) {
      _wrapper = FileSystemEntityWrapper(fse);
    }

    /// Create the file if [createIfNotExists] is set to true (defaults to false).
    else if (createIfNotExists) {
      if (_isFile(_absolutePathString!)) {
        _wrapper = FileSystemEntityWrapper(File(_absolutePathString!)..createSync(recursive: true));
      } else {
        _wrapper = FileSystemEntityWrapper(Directory(_absolutePathString!)..createSync(recursive: true));
      }
    }

    /// Only throw an exception if [fail] is set to true (default).
    else {
      /// Throw a [FileException] because the given path does not exist.
      throw FileException(
          "The given path does not exist. Received path: '$path'");
    }
  }

  late final FileSystemEntityWrapper? _wrapper;

  late final String? _absolutePathString;

  File get file => _wrapper!.file;

  Directory get folder => _wrapper!.folder;

  FileFactory resolve(dynamic path, {createIfNotExists = false}) {
    if (path == null) {
      invalidPath(path);
    }

    if (path is File || path is Directory) {
      return FileFactory(
        "$_absolutePathString$_s${(path as FileSystemEntity).path}",
        createIfNotExists: createIfNotExists,
      );
    }

    if (path is String) {
      return FileFactory(
        "$_absolutePathString$_s$path",
        createIfNotExists: createIfNotExists,
      );
    }

    return invalidPath(path);
  }

  ///Return a File if the path contains a "." or a Directory if not.
  static FileSystemEntity _absolutePath(String path) {
    return _isFile(path) ? File(path).absolute : Directory(path).absolute;
  }

  static bool _isFile(String path) {
    var fileOrFolder = path;

    if (fileOrFolder.contains("/")) {
      fileOrFolder = fileOrFolder.substring(path.lastIndexOf("/"), path.length);
    }

    return fileOrFolder.contains(".");
  }

  static dynamic invalidPath(dynamic path) => throw FileException(""
      "The given path is not valid. "
      "Please specify an absolute path as String or a File."
      "Received path: '$path'");
}

/// [Author] Gillian Buijs.
class FileSystemEntityWrapper {
  FileSystemEntityWrapper(FileSystemEntity entity) {
    _fse = entity;
  }

  late final FileSystemEntity _fse;

  File get file => File(_fse.path);

  Directory get folder => Directory(_fse.path);
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
