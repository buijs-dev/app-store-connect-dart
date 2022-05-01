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

import 'package:appstoreconnect/appstoreconnect.dart';
import 'package:appstoreconnect/src/utils/nullsafe.dart';
import 'package:test/test.dart';

/// Integration Test which uses a real Apple Developer account.
void main() async {
  final service =
      CertificatesService(AppStoreCredentials.fromFile("apple_keys.json"));

  final csrContent = Optional(File("private.csr")).mapOrNull((file) {
    return (file as File).readAsStringSync();
  });

  /// Get the certificate count to check if the count after creation is increased by 1.
  int certificateCount = await service.find().then((res) {
    assert(res.isSuccess, "Failed to get certificate count");
    return res.value!.data.length;
  });

  /// Shared between tests.
  Certificate? certificate;

  /// Create a new signing certificate.
  test('Verify create', () async {
    final response = await service.create(
      certificateType: CertificateType.iosDistribution,
      csrContent: csrContent,
    );

    expect(response.isSuccess, true);
    expect(response.value!.data.type, "certificates");
    certificate = response.value!.data;
  });

  /// Lookup al certificates and check there is 1 certificate more than before.
  test('Verify find', () async {
    final response = await service.find();
    expect(response.isSuccess, true);
    expect(response.value!.data.length, certificateCount + 1);
  });

  test('Verify find with query', () async {
    final response = await service.find((_) => _
      ..filterId = [certificate!.id]
      ..filterSerialNumber = [certificate!.attributes.serialNumber!]
      ..filterDisplayName = [certificate!.attributes.displayName!]
      ..limit = 1);

    expect(response.isSuccess, true);

    final certificate2 = response.value!.data[0];
    expect(certificate!.toString(), certificate2.toString());
  });

  /// Search the new signing certificate by using the ID.
  test('Verify findById', () async {
    final response = await service.findById(certificate!.id);

    expect(response.isSuccess, true);

    final certificate2 = response.value!.data;
    expect(certificate!.toString(), certificate2.toString());
  });

  test('Verify findById with showQuery', () async {
    final response =
        await service.findById(certificate!.id, show: (_) => _..showName);

    expect(response.isSuccess, true);
    final certificate2 = response.value!.data;
    expect(certificate!.attributes.name, certificate2.attributes.name);
  });

  test('Verify revoke', () async {
    final response = await service.revokeById(certificate!.id);

    expect(response.isSuccess, true);
    expect(response.value!, true);
  });

  /// Lookup al certificates and check the total count is the same as when the test started.
  test('Verify find', () async {
    final response = await service.find();

    expect(response.isSuccess, true);
    expect(response.value!.data.length, certificateCount);
  });
}
