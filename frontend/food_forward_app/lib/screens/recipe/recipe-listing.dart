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
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Print'),
              onPressed: () async {
                // Generate and save the PDF
                await _generateAndSavePdf(recipeContent);
              },
            ),
            TextButton(
              child: Text('Close'),
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
                      title: Text(item.recipeText),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
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
