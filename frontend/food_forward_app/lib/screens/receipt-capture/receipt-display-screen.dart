import 'package:flutter/material.dart';
import 'dart:io';

class ReceiptDisplayScreen extends StatelessWidget {
  final String imagePath;

  const ReceiptDisplayScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B72A8),
        title: const Text('Captured Receipts',
          style: TextStyle(
              color: Colors.white, // Set the desired color for the title text
            ),
          )
        ),
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
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.lightBlue, // White text color
                    ),
                    child: const Text('Discard'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Save the image and go back to the previous screen.
                      Navigator.of(context).pop(true); // Return true
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.lightBlue, // White text color
                    ),
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
