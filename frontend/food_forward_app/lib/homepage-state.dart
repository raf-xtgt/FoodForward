import 'package:flutter/material.dart';
import 'package:food_forward_app/homepage.dart';
import 'package:food_forward_app/screens/donations/ngo-donation-add.dart';
import 'package:food_forward_app/screens/donations/ngo-listing.dart';
import 'package:food_forward_app/screens/home/home-screen.dart';
import 'package:food_forward_app/components/bottom-navigation/bottom-navigation.dart';
import 'package:food_forward_app/screens/profile/profile-screen.dart';
import 'package:food_forward_app/screens/receipt-capture/receipt-capture-screen.dart';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:food_forward_app/screens/stock-and-expiry/stock-and-expiry-main/stock-and-expiry-main.dart';
import 'package:food_forward_app/screens/profile/profile-screen.dart';
import 'package:food_forward_app/screens/recipe/recipe-listing.dart';

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Track the index of the selected tab
  CameraDescription? cam; // Mark this as nullable because it's set asynchronously

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Obtain a list of the available cameras on
    // the device.
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

  void _navigateToProfile() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _navigateToProfile,
          ),
        ],
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
                  StockAndExpiryScreen(),
                  RecipeListScreen(),
                  NgoListingScreen(),
                  NgoDonationListingScreen(),
                 ProfileScreen(),
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
