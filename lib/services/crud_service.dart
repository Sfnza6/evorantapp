import 'dart:convert';
import 'package:http/http.dart' as http;

class Crud {
  final http.Client _client = http.Client();

  /// Generic GET. Expects a JSON array.
  Future<List<dynamic>> getData(String url) async {
    final res = await _client.get(Uri.parse(url));
    final text = res.body.trim();
    // strip any leading HTML or garbage
    final idx = text.indexOf(RegExp(r'[\{\[]'));
    final clean = idx > 0 ? text.substring(idx) : text;
    final decoded = jsonDecode(clean);
    if (decoded is List<dynamic>) {
      return decoded;
    }
    throw Exception('Expected JSON list from $url, got ${decoded.runtimeType}');
  }

  /// Generic POST. Expects a JSON object.
  Future<Map<String, dynamic>> postData(
      String url, Map<String, dynamic> data) async {
    // ensure all values are strings
    final body = data.map((k, v) => MapEntry(k, v.toString()));
    final res = await _client.post(Uri.parse(url), body: body);
    final text = res.body.trim();
    final idx = text.indexOf(RegExp(r'[\{\[]'));
    final clean = idx > 0 ? text.substring(idx) : text;
    final decoded = jsonDecode(clean);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    throw Exception('Expected JSON map from $url, got ${decoded.runtimeType}');
  }
}
