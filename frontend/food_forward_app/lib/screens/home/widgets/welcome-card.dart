import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0070b4), // Set the background color to #218db3
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white, // White text color
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Time to build a sustainable community!',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white, // White text color
                        ),
                  ),
                ],
              ),
            ),
            // Image Section with Expanded
            const Expanded(
              flex: 1,
              child: SizedBox(
                height: 100, // Control height, or make it dynamic based on card size
                child: Image(
                  image: AssetImage('lib/assets/images/welcome-image.png'),
                  fit: BoxFit.contain, // Maintain aspect ratio and fit the image in the container
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
