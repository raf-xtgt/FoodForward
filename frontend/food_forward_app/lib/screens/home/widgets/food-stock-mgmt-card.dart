import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/services/stats/stats-service.dart';

class FoodStockMgmtCard extends StatefulWidget {
  const FoodStockMgmtCard({super.key});

  @override
  State<FoodStockMgmtCard> createState() => _FoodStockMgmtCardState();
}

class _FoodStockMgmtCardState extends State<FoodStockMgmtCard> {
  double _elevation = 4.0; // Initial elevation value
  String stockCount = "0"; // Initial value set to "0"

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    print("GET FOOD STOCK HDR");
    String count = await StatService.getInventoryCount(); // Store in a local variable
    setState(() {
      stockCount = count; // Update the state variable with the fetched data
    });
  }


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
          side: const BorderSide(
            color: Color(0xFF3C9CD6), // Blue border color
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF3C9CD6), // White background for the icon
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0), // Padding around the icon
                child: const Icon(
                  Icons.food_bank,
                  size: 50,
                  color: Colors.white, // Set icon color to blue
                ),
              ),
              // Centering the number and text
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    stockCount,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFF3C9CD6), // Blue color for the number
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'Inventory',
                    style: TextStyle(
                      fontSize: 16.0, // Smaller text size
                      color: Color(0xFF3C9CD6), // Blue color for the text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
