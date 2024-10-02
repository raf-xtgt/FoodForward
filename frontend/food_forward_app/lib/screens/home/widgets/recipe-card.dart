import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/services/stats/stats-service.dart';

class ReceipeCard extends StatefulWidget {
  const ReceipeCard({super.key});

  @override
  State<ReceipeCard> createState() => _ReceipeCardState();
}

class _ReceipeCardState extends State<ReceipeCard> {
  double _elevation = 4.0; // Initial elevation value
  String recipeCount = "0"; // Initial value set to "0"

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    print("GET FOOD STOCK HDR");
    String count = await StatService.getRecipeCount(); // Store in a local variable
    setState(() {
      recipeCount = count; // Update the state variable with the fetched data
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
                  color: const Color(0xFF3C9CD6), // Blue background for the icon
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0), // Padding around the icon
                child: const Icon(
                  Icons.fastfood,
                  size: 50,
                  color: Colors.white, // Set icon color to white
                ),
              ),
              // Centering the number and text
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                children: [
                  Text(
                    recipeCount, // Display the recipe count
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFF3C9CD6), // Blue color for the number
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    'Recipes',
                    style: TextStyle(
                      fontSize: 16.0, // Smaller text size
                      color: Color(0xFF3C9CD6), // Blue color for the text
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
