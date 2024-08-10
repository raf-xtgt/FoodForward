import 'package:flutter/material.dart';
import 'package:food_forward_app/homepage.dart';
import 'package:food_forward_app/screens/auth/login/login-screen.dart';
import 'package:food_forward_app/screens/auth/sign-up/signup-screen.dart'; // Import your signup screen
import 'package:food_forward_app/screens/stock-and-expiry/stock-and-expiry-main/stock-and-expiry-main.dart';
import 'package:food_forward_app/utils/auth-utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodForward',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<bool>(
              future: AuthUtils.checkAuthStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData && snapshot.data == true) {
                    return const MyHomePage(title: 'FoodForward');
                  } else {
                    return LoginScreen();
                  }
                }
              },
            ),
        '/home': (context) => const MyHomePage(title: 'FoodForward'),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(), // Add your signup screen route here
        '/stock-and-expirty': (context) => StockAndExpiryScreen(),

      },
    );
  }
}
