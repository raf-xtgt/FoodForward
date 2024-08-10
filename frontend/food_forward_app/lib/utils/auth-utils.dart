import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthUtils {
  static const String baseApiUrl = 'http://10.0.2.2:8080/food-forward';

  

  static Future<bool> checkAuthStatus() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
   String? accessToken = await secureStorage.read(key: 'accessToken');

    if (accessToken != null) {
      // Verify token validity
      final response = await http.get(
        Uri.parse('https://yourapi.com/verify-token'),
        headers: {'Authorization': 'Bearer $accessToken'},
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
