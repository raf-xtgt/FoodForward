import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart'; // Needed for MediaType
import 'package:food_forward_app/api/api-services/shared-utils/api-service.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/food-stock-hdr.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/recipe-hdr.dart';
import 'package:food_forward_app/api/api-services/api-model/db-model/RecipeDto.dart';


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

  static Future<String> getRecipeSuggestion(final List<String> itemNames) async {
    const String url = "${Config.baseApiUrl}/recipe/get-suggestion";
    print("Recipe suggestion URL: $url");

    try {
      final itemDto = {
        "itemList": itemNames
      };
      // Convert the itemDto to JSON
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(itemDto),
      );

      print('Recipe suggestion response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // Assuming the suggestion is stored in the 'suggestion' field
        String suggestion = jsonResponse['data'] ?? 'No suggestion found';
        return suggestion;
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return 'Failed to load recipe suggestion. Status code: ${response.statusCode}';
      }
    } catch (e) {
      print('Error fetching recipe suggestion: $e');
      return 'Error fetching recipe suggestion: $e';
    }
  }


  static Future<http.Response> update(final FoodStockHdrSchema fs ) async {
      const String url =  "${Config.baseApiUrl}/food-stock/update";
      http.Response result = await ApiService.putMethod(fs.toJson(), url);
      return result;
  }

  static Future<http.Response> delete( String foodStockId ) async {
      final String url =  "${Config.baseApiUrl}/food-stock/delete/$foodStockId";
      http.Response result = await ApiService.deleteMethod(url);
      return result;
  }

   static Future<http.Response> saveRecipe(final RecipeDto recipe ) async {
      const String url =  "${Config.baseApiUrl}/recipe/save-recipe";
      http.Response result = await ApiService.postMethod(recipe.toJson(), url);
      return result;
  }

  
  
}
