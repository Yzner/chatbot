import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['response'];
    } else {
      return 'Error: Could not process your request';
    }
  }
}
