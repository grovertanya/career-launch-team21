import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService();
  static const String baseUrl = "http://127.0.0.1:5000";  // Replace with actual backend URL

  Future<Map<String, dynamic>> addItem({
    required String name,
    required double price,
    required String category,
    required String sellerName,
  }) async {
    final url = Uri.parse('$baseUrl/items');

    // Construct the request body
    Map<String, dynamic> requestBody = {
      "name": name,
      "price": price,
      "category": category,
      "seller_name": sellerName,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);  // Successful response
      } else {
        throw Exception('Failed to add item: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}