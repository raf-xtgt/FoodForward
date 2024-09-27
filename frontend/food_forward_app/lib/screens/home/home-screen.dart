import 'package:flutter/material.dart';
import 'package:food_forward_app/screens/home/widgets/welcome-card.dart';
import 'package:food_forward_app/screens/home/widgets/donate-ngo-card.dart';
import 'package:food_forward_app/screens/home/widgets/community-card.dart';
import 'package:food_forward_app/screens/home/widgets/recipe-card.dart';
import 'package:food_forward_app/screens/home/widgets/scan-receipt-card.dart';
import 'package:food_forward_app/screens/home/widgets/food-stock-mgmt-card.dart';
import 'package:food_forward_app/screens/home/widgets/food-stock-stats-card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const WelcomeCard(),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Expanded(child: DonateNgoCard()),
                SizedBox(width: 16.0),
                Expanded(child: ScanReceiptCard()),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Expanded(child: FoodStockMgmtCard()),
                SizedBox(width: 16.0),
                Expanded(child: ReceipeCard()),
              ],
            ),
            const SizedBox(height: 16.0),
            const FoodStockStatsCard(),
            const SizedBox(height: 16.0),
            const Text("Hear from the community"),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 120.0, // Set a fixed height for horizontal scroll area
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CommunityCard(),
                  CommunityCard(),
                  CommunityCard(),
                  CommunityCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
