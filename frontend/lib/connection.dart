import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService();
  static const String baseUrl = 'http://192.168.86.225:5000';

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

  Future<Map<String, dynamic>> addUser({
    required String name,
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users');

    // Construct the request body
    Map<String, dynamic> requestBody = {
      "name": name,
      "username": username,
      "password": password,
      "rating": 0.0,
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
        throw Exception('Failed to add user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<dynamic>> fetchItems(String category) 
    async { 
    final response = await http.get(Uri.parse('$baseUrl/items/searchCategory?category=$category')); 

    if (response.statusCode == 200) { 
      List<dynamic> data = jsonDecode(response.body); 
      return data; 

    } else { 
      throw Exception('Failed to load items: ${response.statusCode}'); } 
    }

  Future<List<dynamic>> fetchUser(String username) 
    async { 
    final response = await http.get(Uri.parse('$baseUrl/user?username=$username')); 

    if (response.statusCode == 200) { 
      List<dynamic> data = jsonDecode(response.body); 
      return data; 

    } else { 
      throw Exception('Failed to load items: ${response.statusCode}'); } 
    }
}