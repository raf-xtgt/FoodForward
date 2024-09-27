import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0), // Space around the bottom navigation
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0), // Apply circular border radius
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF218DB3), // Blue background color for the Bottom Navigation Bar
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Light shadow for elevation effect
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              _buildBottomNavigationBarItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
                selectedIndex: selectedIndex,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.document_scanner,
                label: 'Receipt Capture',
                index: 1,
                selectedIndex: selectedIndex,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.food_bank,
                label: 'Stock & Expiry',
                index: 2,
                selectedIndex: selectedIndex,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.person,
                label: 'Profile',
                index: 3,
                selectedIndex: selectedIndex,
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 4, 49, 109), // Color for selected icon
            unselectedItemColor: Colors.white, // Color for unselected icons
            backgroundColor: Colors.transparent, // Transparent background
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  /// Custom function to build a `BottomNavigationBarItem` with a circular highlight background
  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? Colors.white // White background color for selected item
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: selectedIndex == index
              ? const Color.fromARGB(255, 4, 49, 109) // Deep blue color for selected item icon
              : Colors.white, // White color for unselected item icons
        ),
      ),
      label: label,
    );
  }
}

/// Custom clipper to create a Tic-Tac shape for the bottom navigation bar
class TicTacClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double width = size.width;
    final double height = size.height;

    // Define the Tic-Tac shape using path drawing
    path.moveTo(0, 0);
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);
    path.arcToPoint(
      Offset(0, 0),
      radius: const Radius.circular(40.0),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
