import 'package:flutter/material.dart';
import 'dart:io';

class ReceiptDisplayScreen extends StatelessWidget {
  final String imagePath;

  const ReceiptDisplayScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Column(
        children: [
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Discard the image and go back to the previous screen.
                    Navigator.of(context).pop(false); // Return false
                  },
                  child: const Text('Discard'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Save the image and go back to the previous screen.
                    Navigator.of(context).pop(true); // Return true
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
