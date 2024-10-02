import 'package:flutter/material.dart';

class NgoCard extends StatefulWidget {
  const NgoCard({super.key});

  @override
  State<NgoCard> createState() => _NgoCardState();
}

class _NgoCardState extends State<NgoCard> {
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
                decoration: const BoxDecoration(
                  color: Color(0xFF3C9CD6), // Blue background for the icon
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0), // Padding around the icon
                child: const Icon(
                  Icons.business_center,
                  size: 50,
                  color: Colors.white, // Set icon color to white
                ),
              ),
              const SizedBox(width: 16.0), // Add some space between the icon and text
              // Use Expanded to ensure the text wraps within the available space
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                  children: [
                    Text(
                      "Working towards supporting NGOs worldwide.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B72A8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
