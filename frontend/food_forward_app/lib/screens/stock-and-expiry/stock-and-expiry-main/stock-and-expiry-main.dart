import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/recipe-hdr.dart';
import 'package:pdf/widgets.dart' as pw; // PDF library
import 'dart:io';
import 'package:food_forward_app/screens/stock-and-expiry/stock-and-expiry-edit/stock-and-expiry-edit.dart';
import 'package:food_forward_app/api/api-services/services/food-stock-service/food-stock-service.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/food-stock-hdr.dart';
import 'package:food_forward_app/api/api-services/api-model/db-model/RecipeDto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StockAndExpiryScreen extends StatefulWidget {
  @override
  _StockAndExpiryScreenState createState() => _StockAndExpiryScreenState();
}

class _StockAndExpiryScreenState extends State<StockAndExpiryScreen> {
  List<FoodStockHdrSchema> items = [];
  List<FoodStockHdrSchema> selectedItems = []; // List to keep track of selected items
  String recipeText = '';
  String userId = '';
  int _selectedIndex = 2; // Track the index of the selected tab
  String? _selectedFilter; // Variable to track the selected filter

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
  }

  // Function to get recipe suggestions
  void _getRecipe() async {
    print("GET RECIPE");

    List<String> itemNames = selectedItems.map((item) {
      return item.name;
    }).toList();
    String recipeSuggestion = await FoodStockService.getRecipeSuggestion(itemNames);
    print("Recipe Suggestion: $recipeSuggestion");
    setState(() {
      recipeText = recipeSuggestion; // set recipe
    });
    showRecipeDialog(context, recipeSuggestion);
  }

  // Function to show the recipe dialog
  void showRecipeDialog(BuildContext context, String recipeContent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Recipe Suggestion'),
          content: SizedBox(
            height: 400, // Set a height to limit the dialog size
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    recipeContent,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Print'),
              onPressed: () async {
                await _generateAndSavePdf(recipeContent);
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                await _saveRecipe();
              },
            ),
            TextButton(
              child: const Text('Consume'),
              onPressed: () async {
                await _consumeRecipeItems();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _filterFreshItems() {
    setState(() {
      if (_selectedFilter == 'Fresh') {
        _resetFilter(); // Reset if already selected
      } else {
        _selectedFilter = 'Fresh'; // Set as selected
        items = items.where((item) {
          return item.expiryDate != null && item.expiryDate!.isAfter(DateTime.now().add(const Duration(days: 7)));
        }).toList();
      }
    });
  }

  void _filterNearExpiryItems() {
    setState(() {
      if (_selectedFilter == 'Near Expiry') {
        _resetFilter(); // Reset if already selected
      } else {
        _selectedFilter = 'Near Expiry'; // Set as selected
        items = items.where((item) {
          return item.expiryDate != null && item.expiryDate!.isAfter(DateTime.now()) && item.expiryDate!.isBefore(DateTime.now().add(const Duration(days: 7)));
        }).toList();
      }
    });
  }

  void _filterExpiredItems() {
    setState(() {
      if (_selectedFilter == 'Expired') {
        _resetFilter(); // Reset if already selected
      } else {
        _selectedFilter = 'Expired'; // Set as selected
        items = items.where((item) {
          return item.expiryDate != null && item.expiryDate!.isBefore(DateTime.now());
        }).toList();
      }
    });
  }


  void _resetFilter() {
    // Call this method to reset the filter and show all items
    _getData(); // This method fetches all food stock items again
  }


  Future<void> _generateAndSavePdf(String recipeContent) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(recipeContent),
        ),
      ),
    );

    Directory? downloadsDirectory = Directory('/storage/emulated/0/Download');
    final filePath = '${downloadsDirectory.path}/recipe_suggestion.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    print("PDF saved at: $filePath");
  }

  // Function to save the recipe to the backend
  Future<void> _saveRecipe() async {
    print("SAVE RECIPE");
    String recipe = recipeText;
    final FlutterSecureStorage storage = FlutterSecureStorage();
    final String? userId = await storage.read(key: 'userId');
    RecipeDto recipeDto = RecipeDto(
      recipeText: recipe,
      userId: userId ?? '',
    );
    await FoodStockService.saveRecipe(recipeDto);
  }

  Future<void> _consumeRecipeItems() async {
    print("CONSUME ITEMS IN RECIPE");

    selectedItems.forEach((item) async {
      await FoodStockService.delete(item.guid);
      items.remove(item);
    });
    setState(() {
      items = items;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Consumed recipe items')));
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
                          Icons.food_bank,
                          size: 40, // Slightly smaller icon size
                          color: Colors.white, // Set icon color to white
                        ),
                      ),
                      const SizedBox(height: 8.0), // Spacing between the icon and the text
                      const Text(
                        'Food Stock',
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


          // Removed the date filter TextField and replaced it with the three horizontal cards
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              // Fresh Card
              _buildExpiryStatusCard(
                label: "Fresh",
                color: Colors.green,
                backgroundColor: Colors.green.shade50,
                onTap: () {
                  _filterFreshItems();
                },
                isSelected: _selectedFilter == 'Fresh', // Check if selected
              ),
              // Near Expiry Card
              _buildExpiryStatusCard(
                label: "Near Expiry",
                color: Colors.yellow,
                backgroundColor: Colors.yellow.shade50,
                onTap: () {
                  _filterNearExpiryItems();
                },
                isSelected: _selectedFilter == 'Near Expiry', // Check if selected
              ),
              // Expired Card
              _buildExpiryStatusCard(
                label: "Expired",
                color: Colors.red,
                backgroundColor: Colors.red.shade50,
                onTap: () {
                  _filterExpiredItems();
                },
                isSelected: _selectedFilter == 'Expired', // Check if selected
              ),


              ],
            ),
          ),
          // Display the list of food items
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = selectedItems.contains(item);
                return GestureDetector(
                  onLongPress: () => _toggleSelection(item),
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
              onPressed: _getRecipe,
              tooltip: 'Generate Recipe',
              child: const Icon(Icons.fastfood),
            )
          : null,
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
