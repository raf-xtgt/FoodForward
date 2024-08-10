import 'package:food_forward_app/api/api-services/api-model/db-model/AuthDto.dart';
import 'package:food_forward_app/api/api-services/shared-utils/api-service.dart';
import 'dart:async';
import 'package:food_forward_app/utils/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class SignUpService {
  
  static Future<void> signIn(final AuthDto authDto ) async {
      const String url =  "${Config.baseApiUrl}/auth/sign-in/email-and-password";
            
    try {
      http.Response result = await ApiService.postMethod(authDto.toJson(), url);
      print("Sign in result " + result.toString());
      final Map<String, dynamic> responseBody = json.decode(result.body);
      print(responseBody);

      if (result.statusCode == 200) {
        print('Sign in successful');

      } else {
        print('Sign in failed with status: ${responseBody["statusCode"]}');
      }
    } catch (e) {
      print('Error signing: $e');
    }
  }
  
}
