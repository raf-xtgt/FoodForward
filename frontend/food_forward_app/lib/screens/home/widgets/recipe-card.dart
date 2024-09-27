import 'package:flutter/material.dart';

class ReceipeCard extends StatelessWidget {
  const ReceipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.fastfood, size: 48.0, color: Colors.green),
            const SizedBox(height: 8.0),
            Text(
              'Your Recipes',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
