// api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseApiUrl = 'http://10.0.2.2:8080/food-forward';

  static Future<String> getMethod() async {
    try {
      final response = await http.get(Uri.parse(baseApiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data.toString();
      } else {
        return 'Failed to load data';
      }
    } catch (e) {
      // Handle any errors that occur during the request
      return 'Error: $e';
    }
  }

    static Future<http.Response> postMethod(Map<String, dynamic> requestBody, final String url) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      return response;

    
    } catch (e) {
      return http.Response(
        jsonEncode({'error': 'Error: $e'}),
        500,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    }
  }
}
