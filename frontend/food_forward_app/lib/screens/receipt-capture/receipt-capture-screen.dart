import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:food_forward_app/state/receipt-capture-state/receipt-capture-state.dart';

// A screen that allows users to take a picture using a given camera.
class ReceiptCaptureScreen extends StatefulWidget {
  const ReceiptCaptureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}