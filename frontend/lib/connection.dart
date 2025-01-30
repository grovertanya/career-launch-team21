import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService();
  static const String baseUrl = 'http://10.174.129.101:5000';

  Future<Map<String, dynamic>> addItem({
    required String name,
    required double price,
    required String category,
    required String description,
    required String sellerName,
    required String imageUrl,
  }) async {
    final url = Uri.parse('$baseUrl/items');

    // Construct the request body
    Map<String, dynamic> requestBody = {
      "name": name,
      "price": price,
      "category": category,
      "seller_name": sellerName,
      "description" : description,
      "imageurl" : imageUrl,
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

    Future<Map<String, dynamic>> markItemAsSold({
    required String id,
    required String buyerUsername,
  }) async {
    final url = Uri.parse('$baseUrl/items/checkout?id=$id&username=$buyerUsername');

    // Construct the request body
    Map<String, dynamic> requestBody = {
      'id' : id,
      'username' : buyerUsername,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);  // Successful response
      } else {
        throw Exception('Failed to remove item: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> rateUser({
    required String buyerUsername,
    required String sellerUsername,
    required double rating,
  }) async {
    final url = Uri.parse('$baseUrl/users/rate?rating=$rating&seller_name=$sellerUsername&username=$buyerUsername');

    // Construct the request body
    Map<String, dynamic> requestBody = {
      'rating' : rating,
      'seller_name' : sellerUsername,
      'username' : buyerUsername,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);  // Successful response
      } else {
        throw Exception('Failed to remove item: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String?> uploadImageToBackend(File imageFile) async {
  final uri = Uri.parse("http://10.174.129.101:5000/upload");
  final request = http.MultipartRequest("POST", uri);

  request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
  //we may have to add some sort of image key in the map
  final response = await request.send();
  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    // Parse the URL from the response (assuming plain URL is returned)
    print("Response from backend: $responseBody");
    return responseBody;
  } else {
    print("Upload failed: ${response.statusCode}");
    return null;
  }
}

Future<Map<String, dynamic>> addToWishlist({
  //should probably only pass in the body
    required String name,
    required double price,
    required String category,
    required String description,
    required String sellerName,
    required String imageUrl,
  }) async {
    final url = Uri.parse('$baseUrl/users/'); //need to know the specific url to add to wishlist

    // Construct the request body
    Map<String, dynamic> requestBody = {
      "name": name,
      "price": price,
      "category": category,
      "seller_name": sellerName,
      "description" : description,
      "imageurl" : imageUrl,
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