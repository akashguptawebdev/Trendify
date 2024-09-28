import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('http://localhost:2850/api/v1/user/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Extract token from the response
      String? token = responseData['token'];
      if (token != null) {
        // Save token locally using SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jWT', token);
      }

      // Check if essential fields are null
      if (responseData['_id'] == null) {
        return {
          'success': false,
          'message': 'Invalid response data',
        };
      }

      return {
        'success': true,
        'data': responseData,
      };
    } else {
      // Handle error case by parsing the response body
      try {
        final errorResponse = json.decode(response.body);
        return {
          'success': false,
          'message': errorResponse['message'] ?? 'An error occurred',
        };
      } catch (e) {
        // If the response body is not valid JSON, return a generic error
        return {
          'success': false,
          'message': 'An error occurred. Please try again.',
        };
      }
    }
  }
}
