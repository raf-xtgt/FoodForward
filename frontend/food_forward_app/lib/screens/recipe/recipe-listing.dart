import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/recipe-hdr.dart';
import 'package:food_forward_app/api/api-services/services/recipe/recipe-service.dart';
import 'package:pdf/widgets.dart' as pw; // PDF library

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<RecipeHdrSchema> items = [];
  List<RecipeHdrSchema> selectedItems = []; // List to keep track of selected items
  int? expandedIndex; // Track the currently expanded card index

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

  // Function to display selected item data
  void _showReviewDialog(RecipeHdrSchema item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double rating = 0.0; // Rating for the stars
        final reviewController = TextEditingController(); // Controller for the review text field
        Color borderColor = Colors.blue; // Set your desired border color here
        Color starBorderColor = Colors.yellow; // Set your desired border color here

        return AlertDialog(
          title: const Text('Review Recipe'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        index += 1;
                        rating = index + 1; // Update rating based on the star selected
                      });
                    },
                    child: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: index < rating ? Colors.yellow : starBorderColor, // Fill star with yellow, else border color
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20.0, width: 15,), // Add spacing between stars and text field
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Add padding
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor), // Add a border
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: TextField(
                  controller: reviewController,
                  maxLines: 5, // Make the text field larger by allowing multiple lines
                  decoration: const InputDecoration(
                    labelText: 'Enter your review',
                    border: InputBorder.none, // Remove the default border
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Print the item data to the console
                print("Recipe: ${item.recipeText}, Rating: $rating, Review: ${reviewController.text}");
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save Review'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
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
                  padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0), // Horizontal padding and some vertical space
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF3C9CD6), // Blue background for the icon
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8.0), // Reduced padding around the icon
                        child: const Icon(
                          Icons.edit_document,
                          size: 40, // Slightly smaller icon size
                          color: Colors.white, // Set icon color to white
                        ),
                      ),
                      const SizedBox(height: 8.0), // Spacing between the icon and the text
                      const Text(
                        'Recipes',
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
                          ),
                        ), // Make the card's border rounded
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Recipe #${index + 1} - ${item.createdDate?.toLocal().toString().split(' ')[0]}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.reviews),
                                onPressed: () => _showReviewDialog(item), // Show review dialog
                              ),
                            ),
                            if (isExpanded) ...[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.recipeText), // Show recipe details
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
