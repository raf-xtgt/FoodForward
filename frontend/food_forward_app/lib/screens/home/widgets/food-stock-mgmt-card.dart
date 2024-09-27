import 'package:flutter/material.dart';

class FoodStockMgmtCard extends StatefulWidget {
  const FoodStockMgmtCard({super.key});

  @override
  State<FoodStockMgmtCard> createState() => _FoodStockMgmtCardState();
}

class _FoodStockMgmtCardState extends State<FoodStockMgmtCard> {
  double _elevation = 4.0; // Initial elevation value

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _elevation = 20.0; // Increase elevation on tap down
        });
      },
      onTapUp: (_) {
        setState(() {
          _elevation = 4.0; // Restore elevation on tap up
        });
      },
      onTapCancel: () {
        setState(() {
          _elevation = 4.0; // Restore elevation on tap cancel
        });
      },
      child: Card(
        elevation: _elevation, // Use dynamic elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: const Color(0xFF3C9CD6), // Set background color to #3c9cd6
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.food_bank, 
                size: 50,
                color: const Color(0xFFF4EDED), // Set icon color to #f4eded
              ),
              const SizedBox(height: 8.0),
              Text(
                'Manage Food Stock',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white, // Set text color to white for better contrast
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
