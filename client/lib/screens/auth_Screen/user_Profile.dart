

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileService {
  // Function to get user profile data
  Future<Map<String, dynamic>?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');  // Assume the token is saved after login
    
    if (token == null) {
      return null; // No token found, user is not authenticated
    }

    final url = Uri.parse(' http://localhost:2850/api/v1/user/getUserProfile'); // Your user profile endpoint
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Send JWT in Authorization header
      },
    );

    print(" user $response");

    if (response.statusCode == 200) {
      // Parse the response body and return the user profile data
      final data = json.decode(response.body);
      return data; // User profile data
    } else {
      // Handle errors (e.g., token invalid, user not found)
      print('Failed to fetch user profile: ${response.statusCode}');
      return null;
    }
  }
}
