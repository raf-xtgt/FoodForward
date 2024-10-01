import 'package:food_forward_app/api/api-services/api-model/db-model/DonationDto.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/ngo-donation-hdr.dart';
import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:food_forward_app/api/api-services/shared-utils/api-service.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/ngo-hdr.dart';



class DonationService {
  
  static Future<List<NgoDonationHdrSchema>> getDonationList(String ngoId) async {
      String url = "${Config.baseApiUrl}/ngo-donation/read/all/$ngoId";
      print("donation url: " + url);
    
    try {
      final response = await http.get(Uri.parse(url));
      
      print('donation response: ${response}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'];
        print('donation response data: ${data}');

        // Parse and return the list of FoodItems
        return data.map((item) => NgoDonationHdrSchema.fromJson(item['ngo_donation_hdr'])).toList();
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }

    } catch (e) {
      print('Error uploading images: $e');
      return [];

    }
  }


  static Future<http.Response> create(final DonationDto fs ) async {
      const String url =  "${Config.baseApiUrl}/ngo-donation/create";
      http.Response result = await ApiService.postMethod(fs.toJson(), url);
      return result;
  }
  
  
}
