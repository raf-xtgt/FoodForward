import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-model/AuthDto.dart';
import 'package:food_forward_app/api/api-services/services/auth/sign-up-service.dart';
import 'package:food_forward_app/screens/auth/sign-up/signup-screen.dart'; // Import the sign-up screen
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isButtonEnabled = ValueNotifier<bool>(false);
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

void _login() async {
  if (_formKey.currentState!.validate()) {
    final userId = await storage.read(key: 'userId');
    final email = _emailController.text;
    final password = _passwordController.text;
        
    if (userId != null) {
      AuthDto authDto = AuthDto(
      email: email,
      password: password,
      userId: userId
    );

      try {
        http.Response signInResponse = await SignUpService.logIn(authDto);
        final Map<String, dynamic> responseBody = json.decode(signInResponse.body);

        if (signInResponse.statusCode == 200) {
          // Extract accessToken from the response
          final Map<String, dynamic> responseData = responseBody["data"]["user_profile"];
          final String accessToken = responseData["access_token"];
          final String userId = responseData["guid"];

          // Save accessToken in local storage
          await storage.write(key: 'accessToken', value: accessToken);
          await storage.write(key: 'userId', value: userId);

          // Retrieve and confirm the accessToken from storage
          final storedToken = await storage.read(key: 'accessToken');
          print('Access token retrieved from storage: $storedToken');

          // Redirect to the homepage
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          print('Sign in failed with status: ${responseBody["statusCode"]}');
        }
      } catch (e) {
        print('An error occurred: $e');
      }
    }else{
      print("token is null");
    }

  }
  else{
    print("State is invalid");
  }
}

  void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()), // Navigate to the sign-up screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                    onPressed: isEnabled ? _login : null,
                    child: Text('Login'),
                  );
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _navigateToSignup,
                child: Text(
                  'Sign up here',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
