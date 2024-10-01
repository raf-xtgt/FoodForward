import 'package:flutter/material.dart';
import 'package:food_forward_app/screens/home/widgets/welcome-card.dart';
import 'package:food_forward_app/screens/home/widgets/donate-ngo-card.dart';
import 'package:food_forward_app/screens/home/widgets/recipe-card.dart';
import 'package:food_forward_app/screens/home/widgets/scan-receipt-card.dart';
import 'package:food_forward_app/screens/home/widgets/food-stock-mgmt-card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFF4EC), // Setting the background color
       
       child: const Center(
                child: SizedBox(
                width: double.infinity,
                height: 850.0, // Increase this value to change the height of the camera preview
                child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                WelcomeCard(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: DonateNgoCard()),
                    SizedBox(width: 16.0),
                    Expanded(child: ScanReceiptCard()),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: FoodStockMgmtCard()),
                    SizedBox(width: 16.0),
                    Expanded(child: ReceipeCard()),
                  ],
                ),
                SizedBox(height: 16.0),
                Text("Working towards supporting NGOs worldwide.", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:  Color(0xFF2B72A8),
                    ),
                  ),
              

              ],
            ),
          ),
        ),
      ),
      ),
      ),
    );
  }
}
