import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-model/AuthDto.dart';
import 'package:food_forward_app/api/api-services/services/auth/sign-up-service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isButtonEnabled = ValueNotifier<bool>(false);
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState(){
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _isButtonEnabled.dispose();
    super.dispose();
  }

  void _validateForm(){
    final isEmailValid = _emailController.text.isNotEmpty;
    final isPasswordValid = _passwordController.text.length >= 6;
    _isButtonEnabled.value = isEmailValid && isPasswordValid;
  }


  void _signUp() async {
    if (_formKey.currentState!.validate()){
      final email = _emailController.text;
      final password = _passwordController.text;

      // Print email and password to console (for debugging purposes)
      print('Email: $email');
      print('Password: $password');
      AuthDto authDto = AuthDto(
          email: email,
          password: password
        );
      http.Response signInResponse = await SignUpService.signIn(authDto);
      final Map<String, dynamic> responseBody = json.decode(signInResponse.body);
      print(responseBody);

      if (signInResponse.statusCode == 200) {
        print('Sign in successful');
        // Extract accessToken from the response
        final Map<String, dynamic> responseData = responseBody["data"]["user_profile"];
        print(responseData);
        final String accessToken = responseData["access_token"];
        print(accessToken);
        await storage.write(key: 'accessToken', value: accessToken);
        // Save accessToken in local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);

        // Redirect to the homepage
        Navigator.pushReplacementNamed(context, '/home');

      } else {
        print('Sign in failed with status: ${responseBody["statusCode"]}');
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add a basic email format validation
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                valueListenable: _isButtonEnabled,
                builder: (context, isEnabled, child) {
                  return ElevatedButton(
                    onPressed: isEnabled ? _signUp : null,
                    child: Text('Sign Up'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
