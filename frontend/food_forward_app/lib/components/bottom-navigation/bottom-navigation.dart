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
          height: 60, // Adjust the height of the container for better scrolling experience
          decoration: BoxDecoration(
            color: const Color(0xFF2B72A8), // Blue background color for the Bottom Navigation Bar
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Light shadow for elevation effect
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Make the menu scrollable horizontally
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Spacing between the menu items
              children: <Widget>[
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
                  icon: Icons.edit_document,
                  label: 'Recipe',
                  index: 3,
                  selectedIndex: selectedIndex,
                ),
                _buildBottomNavigationBarItem(
                  icon: Icons.volunteer_activism,
                  label: 'Donations',
                  index: 4,
                  selectedIndex: selectedIndex,
                ),
                // _buildBottomNavigationBarItem(
                //   icon: Icons.person,
                //   label: 'Profile',
                //   index: 5,
                //   selectedIndex: selectedIndex,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Custom function to build a bottom navigation item with a circular highlight background
  Widget _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
  }) {
    return GestureDetector(
      onTap: () => onItemTapped(index), // Handle tap events
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0), // Spacing between each item
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? Colors.white // White background color for selected item
              : Colors.transparent,
          shape: BoxShape.rectangle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selectedIndex == index
                  ? const Color.fromARGB(255, 4, 49, 109) // Deep blue color for selected item icon
                  : Colors.white, // White color for unselected item icons
            ),
            Text(
              label,
              style: TextStyle(
                color: selectedIndex == index
                    ? const Color.fromARGB(255, 4, 49, 109) // Text color for selected item
                    : Colors.white, // Text color for unselected items
              ),
            ),
          ],
        ),
      ),
    );
  }
}
