import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/ngo-hdr.dart';
import 'package:food_forward_app/api/api-services/services/donation/ngo-hdr-service.dart';
import 'package:food_forward_app/api/api-services/services/recipe/recipe-service.dart';
import 'package:food_forward_app/screens/donations/ngo-donation-listing.dart';
import 'package:pdf/widgets.dart' as pw; // PDF library

class NgoListingScreen extends StatefulWidget {
  @override
  _NgoListingScreenState createState() => _NgoListingScreenState();
}

class _NgoListingScreenState extends State<NgoListingScreen> {
  List<NgoHdrSchema> items = [];
  List<NgoHdrSchema> selectedItems = []; // List to keep track of selected items
  int? expandedIndex; // Track the currently expanded card index

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    List<NgoHdrSchema> fetchedItems = await NgoHdrService.getNgoList();
    setState(() {
      items = fetchedItems; // Update the state with the fetched data
    });
  }

  // Function to handle card selection and deselection
  void _toggleSelection(NgoHdrSchema item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item); // Deselect if already selected
      } else {
        selectedItems.add(item); // Select the item
      }
    });
  }

  // Updated function to pass selected item to the next screen
  void _navigateToAddDonation(NgoHdrSchema item) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NgoDonationListingScreen(
          ngoItem: item, // Pass the selected item to the next screen
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4EC),
      body: Column(
        children: [
                      // Header card for "Recipes"
              Align(
                alignment: Alignment.topCenter, // Align at the top center of the screen
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 5.0), // Horizontal padding and some vertical space
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C9CD6), // Blue background for the icon
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8.0), // Reduced padding around the icon
                        child: const Icon(
                          Icons.business_center,
                          size: 40, // Slightly smaller icon size
                          color: Colors.white, // Set icon color to white
                        ),
                      ),
                      const SizedBox(height: 8.0), // Spacing between the icon and the text
                      const Text(
                        'Donate to NGOs',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold, // Text style with bold font
                          color: Color(0xFF3C9CD6), // Blue color for the text
                        ),
                      ),
                    ],
                  ),
                ),
              ),


          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = selectedItems.contains(item);
                final isExpanded = expandedIndex == index; // Check if this card is expanded

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      expandedIndex = isExpanded ? null : index; // Toggle expansion
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding to the left and righ

                  child: Card(
                    color: isSelected ? Colors.blue.shade100 : null, // Change color if selected
                    elevation: 2, // Add some elevation for shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), 
                      side: const BorderSide(
                        color: Color(0xFF3C9CD6), // Blue border color
                        width: 2.0,
                      ),// Make the card's border rounded
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('${item.name}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_circle_right),
                            onPressed: () => _navigateToAddDonation(item), // Pass the item
                          ),
                        ),
                        if (isExpanded) ...[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(item.description), // Show recipe details
                          ),
                        ],
                      ],
                    ),
                  ),
                
                  ),

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
