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

    static Future<String> postMethod(Map<String, dynamic> requestBody) async {
    try {
      const String url = "$baseApiUrl/upload-image/create";
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return data.toString();
      } else {
        return 'Failed to post data: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
