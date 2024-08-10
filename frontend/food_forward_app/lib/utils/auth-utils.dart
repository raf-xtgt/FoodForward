import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static const String baseApiUrl = 'http://10.0.2.2:8080/food-forward';

  

  static Future<bool> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    final userId = prefs.getString('userId');

    if (token != null && userId != null) {
      // Verify token validity
      final response = await http.get(
        Uri.parse('https://yourapi.com/verify-token'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return true; // Token is valid
      } else {
        return false; // Token is not valid
      }
    } else {
      return false; // No token found
    }
  }  
}
