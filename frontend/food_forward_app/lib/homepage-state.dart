import 'package:flutter/material.dart';
import 'package:food_forward_app/homepage.dart';
import 'package:food_forward_app/screens/home/home-screen.dart';
import 'package:food_forward_app/screens/profile/profile-screen.dart';
import 'package:food_forward_app/components/bottom-navigation/bottom-navigation.dart';

class MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0; // Track the index of the selected tab
    // Define a list of widgets to display for each tab
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Display the widget for the selected tab
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}