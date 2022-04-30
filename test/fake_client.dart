import 'dart:io';

import 'package:appstoreconnect/src/shared/client.dart';
import 'package:http/http.dart' as http;

/// Injectable client for testing purposes.
///
/// [Author] Gillian Buijs.
class FakeClient extends AppStoreClient {

  String getResponseBody = "";
  int getResponseCode = 200;

  String postResponseBody = "";
  int postResponseCode = 201;

  String expectedUri = "";
  String expectedRequest = "";

  @override
  Future<http.Response> get({
    required String uri,
    required String jwt,
  }) async {

    assertUri(uri);

    var response = http.Response(getResponseBody, getResponseCode);

    if (response.statusCode != 200) {
      throw HttpException(
          "Http request returned status code " + response.statusCode.toString() +
              " and body: " + response.body,
          uri: Uri.parse(uri));
    }

    return response;
  }

  @override
  Future<http.Response> post({
    required String uri,
    required String body,
    required String jwt,
    Map<String, String> headers = const {},
  }) async {

    assertUri(uri);
    assertRequest(body);

    var response = http.Response(postResponseBody, postResponseCode);

    if (response.statusCode != 201) {
      throw HttpException(
          "Http request returned status code " + response.statusCode.toString() +
              " and body: " + response.body,
          uri: Uri.parse(uri));
    }

    return response;

  }

  void assertUri(String uri) {

    assert (Uri.tryParse(uri) != null, "Invalid URI: '$uri'");

    if(expectedUri != "") {
      var compare = expectedUri;
      //Clear the URI to be sure it does not interfere when client is reused for other test.
      expectedUri = "";
      assert (compare == uri, "Expected URI: '$compare'\nActual URI: $uri");
    }
  }

  void assertRequest(String request) {
    if(expectedRequest != "") {
      //Clear the Request to be sure it does not interfere when client is reused for other test.
      expectedRequest = "";
      assert (expectedRequest.replaceAll(" ", "") == request.replaceAll(" ", ""), "Expected request: '$expectedRequest'\nActual request: $request");
    }
  }

  @override
  Future<http.Response> delete({required String uri, required String jwt}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

}