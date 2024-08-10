import 'package:food_forward_app/api/api-services/api-model/db-model/AuthDto.dart';
import 'package:food_forward_app/api/api-services/shared-utils/api-service.dart';
import 'dart:async';
import 'package:food_forward_app/utils/config.dart';

class SignUpService {
  
  static Future<void> signIn(final AuthDto authDto ) async {
      const String url =  "${Config.baseApiUrl}/auth/sign-in/email-and-password";
            
    try {
      String result = await ApiService.postMethod(authDto.toJson(), url);
      print("Sign in result " + result);

      // if (response.statusCode == 200) {
      //   print('Upload successful');

      // } else {
      //   print('Upload failed with status: ${response.statusCode}');
      // }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }
  
}
