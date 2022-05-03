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

import 'package:app_store_client/connect.dart';

import 'library.dart';

///[Author] Gillian Buijs.
Future<Result<CertificatesResponse>> findCertificates(List<String> args) {
  final credentials = AppStoreCredentialsArgs(args).parse;
  final query = CertificateArgs(args).filters;
  final service = CertificatesService(credentials);
  return service.find((_) => query);
}

/// [Author] Gillian Buijs
class CertificateArgs {
  CertificateArgs(this.args);

  final List<String> args;

  late final Map<String, String> parsedArgs = args.toArgs;

  CertificatesQuery get filters {
    final filterQuery = CertificatesQuery();

    if(parsedArgs.containsKey(Arguments.filterId)) {
      filterQuery.filterId = parsedArgs[Arguments.filterId]!.split(",");
    }

    if(parsedArgs.containsKey(Arguments.filterDisplayName)) {
      filterQuery.filterDisplayName = parsedArgs[Arguments.filterDisplayName]!.split(",");
    }

    if(parsedArgs.containsKey(Arguments.filterSerialNumber)) {
      filterQuery.filterSerialNumber = parsedArgs[Arguments.filterSerialNumber]!.split(",");
    }

    return filterQuery;
  }
}
