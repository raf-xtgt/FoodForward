import 'package:flutter/material.dart';
import 'package:food_forward_app/homepage.dart';
import 'package:food_forward_app/screens/auth/login/login-screen.dart';
import 'package:food_forward_app/utils/auth-utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodForward',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: AuthUtils.checkAuthStatus(),
        builder:(context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else{
            if(snapshot.hasData && snapshot.data == true){
              return const MyHomePage(title: 'FoodForward');
            }
            else{
              return LoginScreen();
            }
          }
        }
      ),
    );
  }
}
