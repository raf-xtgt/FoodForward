import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:food_forward_app/screens/receipt-capture/receipt-capture-screen.dart';
import 'package:food_forward_app/screens/receipt-capture/receipt-display-screen.dart';
import 'package:food_forward_app/api/api-services/services/image-upload-service/image-upload-service.dart';

class TakePictureScreenState extends State<ReceiptCaptureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final List<String> _images = []; // List to store image paths
  int _imagesTaken = 0; // Counter for images taken

  @override
  void initState() {
    super.initState();
    // Create a CameraController to display the current output from the Camera.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> uploadImages() async {
    await ImageUploadService.uploadImages(_images);
    clearImageList();
  }

  void clearImageList() {
    // Clear images if needed
    setState(() {
      _images.clear();
      _imagesTaken = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                  color: const Color(0xFFFFF4EC), // Setting the background color
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 850.0, // Increase this value to change the height of the camera preview
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
                Positioned(
                  top: 20.0,
                  right: 16.0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Images Captured: $_imagesTaken',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: 'cameraButton',
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;

                    // Attempt to take a picture and get the file `image`
                    final image = await _controller.takePicture();

                    if (!context.mounted) return;

                    // If the picture was taken, display it on a new screen.
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ReceiptDisplayScreen(
                          imagePath: image.path,
                        ),
                      ),
                    );

                    // If the user chose to continue, save the image.
                    if (result == true) {
                      setState(() {
                        _images.add(image.path);
                        _imagesTaken++;
                      });
                    }
                  } catch (e) {
                    print(e); // Log error to console
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
              const SizedBox(width: 16.0), // Add spacing between the buttons
              FloatingActionButton(
                heroTag: 'uploadButton',
                onPressed: () {
                  if (_images.isNotEmpty) {
                    uploadImages();
                  } else {
                    print('No images to upload');
                  }
                },
                child: const Icon(Icons.cloud_upload),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
