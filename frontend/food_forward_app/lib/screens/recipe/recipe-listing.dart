import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/recipe-hdr.dart';
import 'package:pdf/widgets.dart' as pw; // PDF library
// For handling permissions on Android
import 'dart:io';
import 'package:food_forward_app/api/api-services/services/recipe/recipe-service.dart';


class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<RecipeHdrSchema> items = [];
   List<RecipeHdrSchema> selectedItems = []; // List to keep track of selected items



  @override
  void initState() {
    super.initState();
    _getData();
    
  }

  void _getData() async {
    print("GET RECIPE HDR");
    List<RecipeHdrSchema> fetchedItems = await RecipeService.getAllRecipes();
    setState(() {
      items = fetchedItems; // Update the state with the fetched data
    });
  }


  // Function to handle card selection and deselection
  void _toggleSelection(RecipeHdrSchema item) {
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
                      title: Text(item.recipeText),
                      trailing: IconButton(
                        icon: const Icon(Icons.reviews),
                        onPressed: () async {
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
    );
  }
}
