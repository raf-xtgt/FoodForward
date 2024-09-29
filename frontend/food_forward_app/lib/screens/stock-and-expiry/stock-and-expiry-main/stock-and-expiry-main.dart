import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/recipe-hdr.dart';
import 'package:pdf/widgets.dart' as pw; // PDF library
// For handling permissions on Android
import 'dart:io';
import 'package:food_forward_app/screens/stock-and-expiry/stock-and-expiry-edit/stock-and-expiry-edit.dart';
import 'package:food_forward_app/api/api-services/services/food-stock-service/food-stock-service.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/food-stock-hdr.dart';
import 'package:food_forward_app/api/api-services/api-model/db-model/RecipeDto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_forward_app/components/bottom-navigation/bottom-navigation.dart';

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


  @override
  void initState() {
    super.initState();
    _getData();
    
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }
  void _getData() async {
    print("GET FOOD STOCK HDR");
    List<FoodStockHdrSchema> fetchedItems = await FoodStockService.getFoodStock();
    setState(() {
      items = fetchedItems; // Update the state with the fetched data
    });
  }

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
                // Generate and save the PDF
                await _generateAndSavePdf(recipeContent);
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                // Generate and save the PDF
                await _saveRecipe();
              },
            ),
            TextButton(
              child: const Text('Consume'),
              onPressed: () async {
                // Generate and save the PDF
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

  Future<void> _generateAndSavePdf(String recipeContent) async {
    // Create a new PDF document
    final pdf = pw.Document();

    // Add a page to the PDF with the recipe content
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(recipeContent),
        ),
      ),
    );

    // Move to the Downloads folder explicitly (for Android compatibility)
    Directory? downloadsDirectory = Directory('/storage/emulated/0/Download');

    // Create the file path in the Downloads directory
    final filePath = '${downloadsDirectory.path}/recipe_suggestion.pdf';

    // Save the PDF file
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Log the file path and show success message
    print("PDF saved at: $filePath");

    // Optionally open or share the file after saving it
  }

  // Function to handle card selection and deselection
  void _toggleSelection(FoodStockHdrSchema item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item); // Deselect if already selected
      } else {
        selectedItems.add(item); // Select the item
      }
    });
  }

  // Function to deselect all items
  void _deselectAllItems() {
    setState(() {
      selectedItems.clear();
    });
  }

  // Function to display selected item data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Filter by date',
                suffixIcon: Icon(Icons.date_range),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                // Handle the picked date
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = selectedItems.contains(item);
                return GestureDetector(
                  onLongPress: () => _toggleSelection(item), // Toggle selection on long press
                  child: Card(
                    color: isSelected ? Colors.blue.shade100 : null, // Change color if selected
                    child: ListTile(
                      leading: isSelected
                          ? IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                _toggleSelection(item);
                              },
                              tooltip: 'Deselect',
                            )
                          : null, // Show cross button on the left if item is selected
                      title: Text(item.name),
                      subtitle: Text('Qty: ${item.quantity ?? 'N/A'}, Price: ${item.unitPrice ?? 'N/A'}'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          final updatedItem = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditStockItemScreen(item: item),
                            ),
                          );

                          // Check if the item was updated and update the state
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
              onPressed: _getRecipe,
              tooltip: 'Generate Recipe',
              child: const Icon(Icons.fastfood),
            )
          : null,
    );
  }
}
