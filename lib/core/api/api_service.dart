import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener los posts');
    }
  }

  Future<http.Response> createPost(int userId, String title, String body) {
    return http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'userId': userId, 'title': title, 'body': body}),
    );
  }
}
