import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart'; // Needed for MediaType
import 'package:food_forward_app/api/api-services/shared-utils/api-service.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/recipe-hdr.dart';
import 'package:food_forward_app/api/api-services/api-model/db-model/RecipeDto.dart';


class RecipeService {
  
  static Future<List<RecipeHdrSchema>> getAllRecipes() async {
      const String url = "${Config.baseApiUrl}/recipe/read/all";
      print("recipe all url: " + url);
    
    try {
      final response = await http.get(Uri.parse(url));
      
      print('recipe read query response: ${response}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];

        // Parse and return the list of FoodItems
        return data.map((item) => RecipeHdrSchema.fromJson(item['recipe_hdr'])).toList();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }

    } catch (e) {
      print('Error uploading images: $e');
      return [];

    }
  }

   static Future<http.Response> saveRecipe(final RecipeDto recipe ) async {
      const String url =  "${Config.baseApiUrl}/recipe/save-recipe";
      http.Response result = await ApiService.postMethod(recipe.toJson(), url);
      return result;
  }

  
  
}
