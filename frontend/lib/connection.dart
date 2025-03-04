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
   // required String imageUrl,
  }) async {
    final url = Uri.parse('$baseUrl/items');

    // Construct the request body
    Map<String, dynamic> requestBody = {
      "name": name,
      "price": price,
      "category": category,
      "seller_name": sellerName,
      "description" : description,
     // "imageurl" : imageUrl,
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

// Future<Map<String, dynamic>?> uploadImageToBackend(File imageFile) async {
//   try {
//     final uri = Uri.parse("http://10.174.129.101:5000/upload");
//     final request = http.MultipartRequest("POST", uri);

//     // Ensure field name is 'image' to match Flask
//     request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

//     final response = await request.send();
//     final responseNew = await http.Response.fromStream(response);

//     print("Response Code: ${response.statusCode}");
//     print("Response Body: ${responseNew.body}");

//     if (response.statusCode == 200) {
//       final data = jsonDecode(responseNew.body);
//       print("Parsed JSON: $data");  
//       return data;
//     } else {
//       print("Error: ${responseNew.body}");
//       return {"error": "HTTP ${response.statusCode}", "body": responseNew.body};
//     }
//   } catch (e) {
//     print("Upload Error: $e");
//     return {"error": "Upload failed", "exception": e.toString()};
//   }
// }

Future<Map<String, dynamic>> addToWishlist({
  //should probably only pass in the body
    required String user,
    required String id,
  }) async {
    final url = Uri.parse('$baseUrl/users/wishlist/add?username=$user&id=$id'); //need to know the specific url to add to wishlist

    // Construct the request body
    Map<String, dynamic> requestBody = {
      "username": user,
      "id": id,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception('Failed to add item: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

Future<List<String>> getWishlist(String username) async {
  final Uri url = Uri.parse('$baseUrl/users/wishlist?username=$username');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey('wishlist')) {
      return List<String>.from(data['wishlist']);
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to fetch wishlist: ${response.body}');
  }
}
  
}