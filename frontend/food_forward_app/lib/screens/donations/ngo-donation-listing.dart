import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/ngo-hdr.dart';
import 'package:food_forward_app/api/api-services/services/donation/ngo-hdr-service.dart';
import 'package:food_forward_app/api/api-services/services/recipe/recipe-service.dart';
import 'package:food_forward_app/components/bottom-navigation/bottom-navigation.dart';
import 'package:food_forward_app/screens/donations/ngo-donation-add.dart';
import 'package:food_forward_app/screens/profile/profile-screen.dart';
import 'package:pdf/widgets.dart' as pw; // PDF library

class NgoDonationListingScreen extends StatefulWidget {
  final NgoHdrSchema? ngoItem; 
  NgoDonationListingScreen({required this.ngoItem});
  @override
  _NgoDonationListingScreenState createState() => _NgoDonationListingScreenState();
}

class _NgoDonationListingScreenState extends State<NgoDonationListingScreen> {
  List<NgoHdrSchema> items = [];
  List<NgoHdrSchema> selectedItems = []; // List to keep track of selected items
  int? expandedIndex; // Track the currently expanded card index
  int _selectedIndex = 4; // Track the index of the selected tab

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    print(widget.ngoItem?.code);
        print(widget.ngoItem?.guid);
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

  void _navigateToProfile() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  // Handle the add button press event
  void _onAddButtonPressed() async {
    print('Add button pressed');
    
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NgoDonationAddScreen(ngoItemId: widget.ngoItem?.guid.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Ngo Donation Listing"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _navigateToProfile,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
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
                      child: Card(
                        color: isSelected ? Colors.blue.shade100 : null, // Change color if selected
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${item.code}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.track_changes),
                                onPressed: () => print(item.name), // Show review dialog
                              ),
                            ),
                            if (isExpanded)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.description), // Show recipe details
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            right: 16, // Adjust the distance from the left edge of the screen
            bottom: 16, // Adjust the distance from the bottom of the screen
            child: FloatingActionButton(
              onPressed: _onAddButtonPressed,
              child: Icon(Icons.add),
              backgroundColor: Colors.lightBlue,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
