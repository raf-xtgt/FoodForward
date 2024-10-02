import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:food_forward_app/api/api-services/api-model/db-schema/recipe-hdr.dart';


class StatService {
  
  static Future<String> getRecipeCount() async {
      const String url = "${Config.baseApiUrl}/recipe/read/all";
      print("recipe all url: " + url);
    
    try {
      final response = await http.get(Uri.parse(url));
      
      print('recipe read query response: ${response}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        print("RECIEPS" + data.length.toString());
        // Parse and return the list of FoodItems
        return data.length.toString();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return "0";
      }

    } catch (e) {
      print('Error uploading images: $e');
      return "0";

    }
  }

  static Future<String> getScanCount() async {
      const String url = "${Config.baseApiUrl}/upload-image/read/all";
      print("recipe all url: " + url);
    
    try {
      final response = await http.get(Uri.parse(url));
      
      print('recipe read query response: ${response}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        print("SCANS" + data.length.toString());
        // Parse and return the list of FoodItems
        return data.length.toString();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return "0";
      }

    } catch (e) {
      print('Error uploading images: $e');
      return "0";

    }
  }

  static Future<String> getInventoryCount() async {
      const String url = "${Config.baseApiUrl}/food-stock/read/all";
      print("recipe all url: " + url);
    
    try {
      final response = await http.get(Uri.parse(url));
      
      print('recipe read query response: ${response}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        print("SCANS" + data.length.toString());
        // Parse and return the list of FoodItems
        return data.length.toString();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return "0";
      }

    } catch (e) {
      print('Error uploading images: $e');
      return "0";

    }
  }

  static Future<String> getDonationCount() async {
      const String url = "${Config.baseApiUrl}/ngo-donation/read/all";
      print("recipe all url: " + url);
    
    try {
      final response = await http.get(Uri.parse(url));
      
      print('recipe read query response: ${response}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        print("SCANS" + data.length.toString());
        // Parse and return the list of FoodItems
        return data.length.toString();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return "0";
      }

    } catch (e) {
      print('Error uploading images: $e');
      return "0";

    }
  }

  
  
}
