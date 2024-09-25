import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:http_parser/http_parser.dart'; // Needed for MediaType

class FoodStockService {
  
  static Future<void> getFoodStock() async {
      const String url = "${Config.baseApiUrl}/food-forward/food-stock/read/all";
      print("food stock url: " + url);
    
    try {
      final request = await http.get(Uri.parse(url));
      print('food stock query response: ${request}');

    } catch (e) {
      print('Error uploading images: $e');
    }
  }
  
}
