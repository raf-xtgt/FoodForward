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
      backgroundColor: const Color(0xFFFFF4EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B72A8),
        title: const Text("Donations",
        style: TextStyle(
            color: Colors.white, // Set the desired color for the title text
          ),),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white,),
            onPressed: _navigateToProfile,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
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
                          Icons.volunteer_activism,
                          size: 40, // Slightly smaller icon size
                          color: Colors.white, // Set icon color to white
                        ),
                      ),
                      const SizedBox(height: 8.0), // Spacing between the icon and the text
                      const Text(
                        'Your Donations',
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
                    
                    return GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding to the left and righ
                        child: Card(
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
                                title: Text('Donation #${item.docNo}'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.track_changes),
                                  onPressed: () => print(item.ngoCode), // Show review dialog
                                ),
                              ),
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
          Positioned(
            right: 16, // Adjust the distance from the left edge of the screen
            bottom: 16, // Adjust the distance from the bottom of the screen
            child: FloatingActionButton(
              onPressed: _onAddButtonPressed,
              child: Icon(Icons.add, color: Colors.white),
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
