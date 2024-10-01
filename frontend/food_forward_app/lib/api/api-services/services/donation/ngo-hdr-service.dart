import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:food_forward_app/api/api-services/shared-utils/api-service.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/ngo-hdr.dart';



class NgoHdrService {
  
  static Future<List<NgoHdrSchema>> getNgoList() async {
      const String url = "${Config.baseApiUrl}/ngo/read/all";
      print("food stock url: " + url);
    
    try {
      final response = await http.get(Uri.parse(url));
      
      print('food stock query response: ${response}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];

        // Parse and return the list of FoodItems
        return data.map((item) => NgoHdrSchema.fromJson(item['ngo_hdr'])).toList();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }

    } catch (e) {
      print('Error uploading images: $e');
      return [];

    }
  }

  static Future<http.Response> update(final NgoHdrSchema fs ) async {
      const String url =  "${Config.baseApiUrl}/ngo/update";
      http.Response result = await ApiService.putMethod(fs.toJson(), url);
      return result;
  }

  static Future<http.Response> delete( String foodStockId ) async {
      final String url =  "${Config.baseApiUrl}/ngo/delete/$foodStockId";
      http.Response result = await ApiService.deleteMethod(url);
      return result;
  }
  
  
}
