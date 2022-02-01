abstract class HttpClient {
  Future<void> request({
    required String url,
    required String method,
    Map<String, dynamic> body,
  });
}
