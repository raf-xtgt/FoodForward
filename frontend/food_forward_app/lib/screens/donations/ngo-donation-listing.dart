import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/ngo-donation-hdr.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/ngo-hdr.dart';
import 'package:food_forward_app/api/api-services/services/donation/donation-service.dart';
import 'package:food_forward_app/components/bottom-navigation/bottom-navigation.dart';
import 'package:food_forward_app/screens/donations/ngo-donation-add.dart';
import 'package:food_forward_app/screens/profile/profile-screen.dart';

class NgoDonationListingScreen extends StatefulWidget {
  final NgoHdrSchema? ngoItem; 
  NgoDonationListingScreen({required this.ngoItem});
  @override
  _NgoDonationListingScreenState createState() => _NgoDonationListingScreenState();
}

class _NgoDonationListingScreenState extends State<NgoDonationListingScreen> {
  List<NgoDonationHdrSchema> items = [];
  List<NgoDonationHdrSchema> selectedItems = []; // List to keep track of selected items
  int? expandedIndex; // Track the currently expanded card index
  int _selectedIndex = 4; // Track the index of the selected tab

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
      print(widget.ngoItem?.guid);
    List<NgoDonationHdrSchema> fetchedItems = await DonationService.getDonationList(widget.ngoItem!.guid);
    setState(() {
      items = fetchedItems; // Update the state with the fetched data
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
                    
                    return GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Donation #${item.docNo}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.track_changes),
                                onPressed: () => print(item.ngoCode), // Show review dialog
                              ),
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
              shape: CircleBorder(),
              elevation: 10.0, 
              highlightElevation: 15.0,
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
