import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const _baseUrl = 'https://potterapi-fedeperin.vercel.app/en';

  Future<List<Map<String, dynamic>>> getList(String path) async {
    final res = await http.get(Uri.parse('$_baseUrl/$path'));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat data (${res.statusCode})');
    }
    return List<Map<String, dynamic>>.from(jsonDecode(res.body) as List);
  }
}