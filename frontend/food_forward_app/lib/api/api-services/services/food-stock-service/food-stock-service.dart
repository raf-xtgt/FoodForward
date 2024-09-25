import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart'; // Needed for MediaType
import 'package:food_forward_app/api/api-services/api-model/db-schema/food-stock-hdr.dart';
class FoodStockService {
  
  static Future<List<FoodStockHdrSchema>> getFoodStock() async {
      const String url = "${Config.baseApiUrl}/food-stock/read/all";
      print("food stock url: " + url);
    
    try {
      final response = await http.get(Uri.parse(url));
      
      print('food stock query response: ${response}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];

        // Parse and return the list of FoodItems
        return data.map((item) => FoodStockHdrSchema.fromJson(item['food_stock_hdr'])).toList();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }

    } catch (e) {
      print('Error uploading images: $e');
      return [];

    }
  }
  
}
