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

import 'dart:convert';
import 'dart:io';

import '../../connect.dart';
import '../utils/files.dart';

import 'library.dart';

/// Find all certificates.
///
/// Arguments:
/// [Arguments.filterId] => search for one or more ID's.
/// [Arguments.filterSerialNumber] => search for one or more SerialNumbers.
/// [Arguments.filterDisplayName] => search for one or more DisplayNames.
/// [Arguments.path] => specify path where to write the found certificates.
/// Default path is 'Home/Library/MobileDevice/Certificates'.
///
/// Returns [CertificateResponse].
///
///[Author] Gillian Buijs.
Future<CertificateResponse> findCertificates(List<String> args) async {
  final credentials = AppStoreCredentialsArgs(args).parse;
  final arguments = CertificateArgs(args);
  final query = arguments.query;
  final path = arguments.path;
  final service = CertificatesService(credentials);
  final result = await service.find((_) => query);

  if (!result.isSuccess) {
    return CertificateResponse(warnings: result.warnings, isSuccess: false);
  }

  var downloaded = 0;
  final info = <String>[];
  final warnings = result.warnings;
  final certificates = result.value?.data;

  certificates?.forEach((certificate) {
    final csrContent = certificate.attributes.certificateContent;

    if (csrContent == null) {
      warnings.add(
        "Can not store a retrieved signing certificate without certificateContent.",
      );
    } else {
      // Create File link
      final type = certificate.type;
      final id = certificate.id;
      final filename = "${type}_$id.cer";
      final file = File(
        "${path.absolute.path}${Platform.pathSeparator}$filename",
      );

      // Abort if File already exists
      if (file.existsSync()) {
        warnings.add("Certificate already exists: ${file.absolute.path}.");
      } else {
        // Decode CSR content.
        final content = Base64Decoder().convert(csrContent);
        file.createSync();
        file.writeAsBytesSync(content);

        if (file.existsSync()) {
          downloaded += 1;
          info.add("Download certificate to: ${file.absolute.path}");
        } else {
          warnings.add("Failed to download certificate: ${file.absolute.path}");
        }
      }
    }
  });

  return CertificateResponse(
    isSuccess: true,
    warnings: warnings,
    info: info,
    count: downloaded,
  );
}

/// [Author] Gillian Buijs
class CertificateResponse {
  const CertificateResponse({
    required this.isSuccess,
    this.warnings = const [],
    this.info = const [],
    this.count = 0,
  });

  final bool isSuccess;
  final List<String> warnings;
  final List<String> info;
  final int count;
}

/// [Author] Gillian Buijs
class CertificateArgs {
  CertificateArgs(this.args);

  final List<String> args;

  late final Map<String, String> parsedArgs = args.toArgs;

  CertificatesQuery get query {
    final filterQuery = CertificatesQuery();

    if (parsedArgs.containsKey(Arguments.filterId)) {
      filterQuery.filterId = parsedArgs[Arguments.filterId]!.split(",");
    }

    if (parsedArgs.containsKey(Arguments.filterDisplayName)) {
      filterQuery.filterDisplayName =
          parsedArgs[Arguments.filterDisplayName]!.split(",");
    }

    if (parsedArgs.containsKey(Arguments.filterSerialNumber)) {
      filterQuery.filterSerialNumber =
          parsedArgs[Arguments.filterSerialNumber]!.split(",");
    }

    return filterQuery;
  }

  /// Return [Directory] specified by the '--path' command-line argument
  /// or default [Directory] 'Home/Library/MobileDevice/Certificates'.
  Directory get path {
    if (parsedArgs.containsKey(Arguments.path)) {
      return FileFactory(parsedArgs[Arguments.path]).folder;
    }

    return FileFactory("${Platform.environment['HOME']}/Library/MobileDevice")
        .resolve("Certificates", createIfNotExists: true)
        .folder;
  }
}
