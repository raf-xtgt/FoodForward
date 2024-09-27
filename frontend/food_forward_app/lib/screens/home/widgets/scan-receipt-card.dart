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
            Icon(Icons.document_scanner, size: 48.0, color: Colors.green),
            const SizedBox(height: 8.0),
            Text(
              'Capture Grocery Receipt',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
