import 'dart:async';
import 'dart:io';

import 'package:app_store_connect/src/service/service_client.dart';

/// Injectable client for testing purposes.
///
/// [Author] Gillian Buijs.
class TestClient extends AppStoreClient {
  String getResponseBody = "";
  int getResponseCode = 200;

  String postResponseBody = "";
  int postResponseCode = 201;

  String expectedUri = "";
  String expectedRequest = "";

  @override
  Future<HttpClientResponse> get({
    required String uri,
    required String jwt,
  }) async {
    assertUri(uri);

    return TestResponse(getResponseBody, getResponseCode);
  }

  @override
  Future<HttpClientResponse> post({
    required String uri,
    required String body,
    required String jwt,
    Map<String, String> headers = const {},
  }) async {
    assertUri(uri);
    assertRequest(body);

    return TestResponse(postResponseBody, postResponseCode);
  }

  void assertUri(String uri) {
    assert(Uri.tryParse(uri) != null, "Invalid URI: '$uri'");

    if (expectedUri != "") {
      var compare = expectedUri;
      //Clear the URI to be sure it does not interfere when client is reused for other test.
      expectedUri = "";
      assert(compare == uri, "Expected URI: '$compare'\nActual URI: $uri");
    }
  }

  void assertRequest(String request) {
    if (expectedRequest != "") {
      //Clear the Request to be sure it does not interfere when client is reused for other test.
      expectedRequest = "";
      assert(expectedRequest.replaceAll(" ", "") == request.replaceAll(" ", ""),
          "Expected request: '$expectedRequest'\nActual request: $request");
    }
  }

  @override
  Future<HttpClientResponse> delete(
      {required String uri, required String jwt}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<HttpClientResponse> patch(
      {required String uri,
      required String body,
      required String jwt,
      Map<String, String> headers = const {}}) {
    // TODO: implement patch
    throw UnimplementedError();
  }
}

class TestResponse extends HttpClientResponse {
  TestResponse(this.responseBody, this.statusCode);

  final String responseBody;

  @override
  final int statusCode;

  @override
  Stream<S> transform<S>(StreamTransformer<List<int>, S> streamTransformer) {
    return Stream.value(responseBody as dynamic);
  }

  @override
  Future<bool> any(bool Function(List<int> element) test) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> asBroadcastStream(
      {void Function(StreamSubscription<List<int>> subscription)? onListen,
      void Function(StreamSubscription<List<int>> subscription)? onCancel}) {
    // TODO: implement asBroadcastStream
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(List<int> event) convert) {
    // TODO: implement asyncExpand
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(List<int> event) convert) {
    // TODO: implement asyncMap
    throw UnimplementedError();
  }

  @override
  Stream<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  // TODO: implement certificate
  X509Certificate? get certificate => throw UnimplementedError();

  @override
  // TODO: implement compressionState
  HttpClientResponseCompressionState get compressionState =>
      throw UnimplementedError();

  @override
  // TODO: implement connectionInfo
  HttpConnectionInfo? get connectionInfo => throw UnimplementedError();

  @override
  Future<bool> contains(Object? needle) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  // TODO: implement contentLength
  int get contentLength => throw UnimplementedError();

  @override
  // TODO: implement cookies
  List<Cookie> get cookies => throw UnimplementedError();

  @override
  Future<Socket> detachSocket() {
    // TODO: implement detachSocket
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> distinct(
      [bool Function(List<int> previous, List<int> next)? equals]) {
    // TODO: implement distinct
    throw UnimplementedError();
  }

  @override
  Future<E> drain<E>([E? futureValue]) {
    // TODO: implement drain
    throw UnimplementedError();
  }

  @override
  Future<List<int>> elementAt(int index) {
    // TODO: implement elementAt
    throw UnimplementedError();
  }

  @override
  Future<bool> every(bool Function(List<int> element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Stream<S> expand<S>(Iterable<S> Function(List<int> element) convert) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  // TODO: implement first
  Future<List<int>> get first => throw UnimplementedError();

  @override
  Future<List<int>> firstWhere(bool Function(List<int> element) test,
      {List<int> Function()? orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  Future<S> fold<S>(
      S initialValue, S Function(S previous, List<int> element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Future forEach(void Function(List<int> element) action) {
    // TODO: implement forEach
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> handleError(Function onError,
      {bool Function(dynamic error)? test}) {
    // TODO: implement handleError
    throw UnimplementedError();
  }

  @override
  // TODO: implement headers
  HttpHeaders get headers => throw UnimplementedError();

  @override
  // TODO: implement isBroadcast
  bool get isBroadcast => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  Future<bool> get isEmpty => throw UnimplementedError();

  @override
  // TODO: implement isRedirect
  bool get isRedirect => throw UnimplementedError();

  @override
  Future<String> join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  // TODO: implement last
  Future<List<int>> get last => throw UnimplementedError();

  @override
  Future<List<int>> lastWhere(bool Function(List<int> element) test,
      {List<int> Function()? orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  // TODO: implement length
  Future<int> get length => throw UnimplementedError();

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    // TODO: implement listen
    throw UnimplementedError();
  }

  @override
  Stream<S> map<S>(S Function(List<int> event) convert) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  // TODO: implement persistentConnection
  bool get persistentConnection => throw UnimplementedError();

  @override
  Future pipe(StreamConsumer<List<int>> streamConsumer) {
    // TODO: implement pipe
    throw UnimplementedError();
  }

  @override
  // TODO: implement reasonPhrase
  String get reasonPhrase => throw UnimplementedError();

  @override
  Future<HttpClientResponse> redirect(
      [String? method, Uri? url, bool? followLoops]) {
    // TODO: implement redirect
    throw UnimplementedError();
  }

  @override
  // TODO: implement redirects
  List<RedirectInfo> get redirects => throw UnimplementedError();

  @override
  Future<List<int>> reduce(
      List<int> Function(List<int> previous, List<int> element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  // TODO: implement single
  Future<List<int>> get single => throw UnimplementedError();

  @override
  Future<List<int>> singleWhere(bool Function(List<int> element) test,
      {List<int> Function()? orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> skipWhile(bool Function(List<int> element) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> takeWhile(bool Function(List<int> element) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> timeout(Duration timeLimit,
      {void Function(EventSink<List<int>> sink)? onTimeout}) {
    // TODO: implement timeout
    throw UnimplementedError();
  }

  @override
  Future<List<List<int>>> toList() {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Future<Set<List<int>>> toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> where(bool Function(List<int> event) test) {
    // TODO: implement where
    throw UnimplementedError();
  }
}
