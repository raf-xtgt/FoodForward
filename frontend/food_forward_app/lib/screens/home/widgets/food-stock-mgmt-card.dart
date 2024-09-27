import 'package:flutter/material.dart';
import 'package:food_forward_app/screens/stock-and-expiry/stock-and-expiry-main/stock-and-expiry-main.dart';

class FoodStockMgmtCard extends StatelessWidget {
  const FoodStockMgmtCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to StockAndExpiryScreen when the card is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StockAndExpiryScreen(),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(Icons.food_bank, size: 48.0, color: Colors.green),
              const SizedBox(height: 8.0),
              Text(
                'Manage Food Stock',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
