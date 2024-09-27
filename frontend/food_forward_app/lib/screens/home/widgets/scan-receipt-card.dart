import 'package:flutter/material.dart';

class ScanReceiptCard extends StatelessWidget {
  const ScanReceiptCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.volunteer_activism, size: 48.0, color: Colors.green),
            const SizedBox(height: 8.0),
            Text(
              'Donate to NGOs',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
