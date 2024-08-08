import 'package:flutter/material.dart';
import 'package:food_forward_app/homepage.dart';
import 'package:food_forward_app/screens/home/home-screen.dart';
import 'package:food_forward_app/screens/profile/profile-screen.dart';
import 'package:food_forward_app/components/bottom-navigation/bottom-navigation.dart';
import 'package:food_forward_app/screens/receipt-capture/receipt-capture-screen.dart';
import 'dart:async';

import 'package:camera/camera.dart';
class MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0; // Track the index of the selected tab
  CameraDescription? cam; // Mark this as nullable because it's set asynchronously

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();
    // Assign the first camera to cam if cameras list is not empty
    if (cameras.isNotEmpty) {
      setState(() {
        cam = cameras.first;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  Future<CameraDescription> getCameras() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    return cameras.first;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: cam == null
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner until camera is initialized
          : Center(
              // Display the widget for the selected tab
              child: IndexedStack(
                index: _selectedIndex,
                children: <Widget>[
                  const HomeScreen(),
                  if (cam != null) ReceiptCaptureScreen(camera: cam!), // Ensure cam is not null before using it
                  const ProfileScreen(),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}