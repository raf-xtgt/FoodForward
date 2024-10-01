import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_forward_app/api/api-services/api-model/db-model/DonationDto.dart';
import 'package:food_forward_app/api/api-services/services/donation/donation-service.dart';
import 'package:food_forward_app/components/bottom-navigation/bottom-navigation.dart';
import 'package:food_forward_app/screens/profile/profile-screen.dart';
import 'package:food_forward_app/screens/stock-and-expiry/stock-and-expiry-edit/stock-and-expiry-edit.dart';
import 'package:food_forward_app/api/api-services/services/food-stock-service/food-stock-service.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/food-stock-hdr.dart';

class NgoDonationAddScreen extends StatefulWidget {
  final String? ngoItemId; 
  NgoDonationAddScreen({required this.ngoItemId});
  @override
  _NgoDonationAddScreenState createState() => _NgoDonationAddScreenState();
}

class _NgoDonationAddScreenState extends State<NgoDonationAddScreen> {
  List<FoodStockHdrSchema> items = [];
  List<FoodStockHdrSchema> selectedItems = []; // List to keep track of selected items
  String recipeText = '';
  String userId = '';
  String? _selectedFilter = 'Near Expiry'; // Variable to track the selected filter
  int _selectedIndex = 4; // Track the index of the selected tab

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    print("GET FOOD STOCK HDR");
    List<FoodStockHdrSchema> fetchedItems = await FoodStockService.getFoodStock();
    setState(() {
      items = fetchedItems; // Update the state with the fetched data
    });
    _filterNearExpiryItems();
  }

  void _addDonation() async {
    List<String> selectedItemIds = selectedItems.map((item) {
      return item.guid;
    }).toList();
    final FlutterSecureStorage storage = FlutterSecureStorage();

    final String? userId = await storage.read(key: 'userId');

    DonationDto donationDto = DonationDto (
        ngoGuid: widget.ngoItemId ?? '',
        userId: userId ?? '',
        foodStockGuids: selectedItemIds
      );
    var result =  await DonationService.create(donationDto);
    if (result.statusCode == 200){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Food donation initiated successfully'))); 
    }
  }



  void _filterNearExpiryItems() {
    setState(() {
      _selectedFilter = 'Near Expiry'; // Set as selected
      items = items.where((item) {
          return item.expiryDate != null && item.expiryDate!.isAfter(DateTime.now()) && item.expiryDate!.isBefore(DateTime.now().add(const Duration(days: 7)));
      }).toList();
      
    });
  }


  void _resetFilter() {
    // Call this method to reset the filter and show all items
    _getData(); // This method fetches all food stock items again
  }


  // Function to toggle selection of items
  void _toggleSelection(FoodStockHdrSchema item) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Add Donation "),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _navigateToProfile,
          ),
        ],
      ),
      body: Column(
        children: [
          // Display the list of food items
          Expanded(
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      final isSelected = selectedItems.contains(item);
      return GestureDetector(
        onLongPress: () => _toggleSelection(item),
        child: Card(
          color: isSelected ? Colors.blue.shade100 : null, // Change color if selected
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min, // Use minimum space
              children: [
                // Deselect icon only when the item is selected
                if (isSelected)
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.red), // Deselect icon
                    onPressed: () {
                      _toggleSelection(item); // Deselect the item
                    },
                  ),
                _buildExpiryIndicator(item.expiryDate), // Display expiry indicator
              ],
            ),
            title: Text(item.name),
            subtitle: Text('Qty: ${item.quantity ?? 'N/A'}, Price: ${item.unitPrice ?? 'N/A'}, Expiry: ${item.expiryDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final updatedItem = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditStockItemScreen(item: item),
                  ),
                );

                if (updatedItem != null && updatedItem is FoodStockHdrSchema) {
                  setState(() {
                    items[index] = updatedItem; // Update the item in the list
                  });
                }
              },
            ),
          ),
        ),
      );
    },
  ),
),
        ],
      ),
      // Floating action button to show selected items
      floatingActionButton: selectedItems.isNotEmpty
          ? FloatingActionButton(
              onPressed: _addDonation,
              tooltip: 'Donate Food Stock',
              child: const Icon(Icons.volunteer_activism),
            )
          : null,

          bottomNavigationBar: BottomNavigation(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
        ),
    );
  }

Widget _buildExpiryStatusCard({
  required String label,
  required Color color,
  required Color backgroundColor,
  required VoidCallback onTap,
  bool isSelected = false, // New parameter to indicate selection
}) {
  return Material(
    elevation: 4,
    borderRadius: BorderRadius.circular(20.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: onTap,
      child: Container(
        width: 110,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.0),
          border: isSelected ? Border.all(color: Colors.blue, width: 2) : null, // Blue border if selected
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  // Function to display the colored indicator based on expiry date
  Widget _buildExpiryIndicator(DateTime? expiryDate) {
    if (expiryDate == null) {
      return const CircleAvatar(
        backgroundColor: Colors.grey, // Default grey if no expiry date
        radius: 10,
      );
    }

    DateTime currentDate = DateTime.now();
    DateTime nearExpiryDate = currentDate.add(const Duration(days: 7));

    Color indicatorColor;
    if (expiryDate.isAfter(nearExpiryDate)) {
      indicatorColor = Colors.green; // Fresh
    } else if (expiryDate.isAfter(currentDate) && expiryDate.isBefore(nearExpiryDate)) {
      indicatorColor = Colors.yellow; // Near expiry
    } else {
      indicatorColor = Colors.red; // Expired
    }

    return CircleAvatar(
      backgroundColor: indicatorColor,
      radius: 10,
    );
  }
}
