import 'package:food_forward_app/api/api-services/api-model/db-model/AuthDto.dart';
import 'package:food_forward_app/api/api-services/shared-utils/api-service.dart';
import 'dart:async';
import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;


class SignUpService {
  
  static Future<http.Response> signIn(final AuthDto authDto ) async {
      const String url =  "${Config.baseApiUrl}/auth/sign-in/email-and-password";
      http.Response result = await ApiService.postMethod(authDto.toJson(), url);
      return result;
  }
  
}
