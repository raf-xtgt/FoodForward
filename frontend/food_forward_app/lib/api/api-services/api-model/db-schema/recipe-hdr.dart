import 'package:intl/intl.dart';

class RecipeHdrSchema {
  final String guid;
  final String recipeText;
  final int recipeStars;
  final String recipeReview;
  final String createdById;
  final String updatedById;
  final DateTime createdDate;
  final DateTime updatedDate;
  final DateTime expiryDate;


  RecipeHdrSchema({
    required this.guid,
    required this.recipeText,
    required this.recipeStars,
    required this.recipeReview,
    required this.createdById,
    required this.updatedById,
    required this.createdDate,
    required this.updatedDate,
    required this.expiryDate,
  });

  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      "recipe_hdr" :{
        'guid': guid,
        'recipe_text': recipeText,
        'recipe_stars': recipeStars,
        'recipe_reiview': recipeReview,
        'created_by_user_guid': createdById,
        'updated_by_user_guid': updatedById,
        'created_date':  formatDate(createdDate),
        'updated_date': formatDate(updatedDate),
        'expiry_date': formatDate(expiryDate),
      }
    };
  }

   // Create a factory constructor to create FoodItem from JSON
  factory RecipeHdrSchema.fromJson(Map<String, dynamic> json) {
    return RecipeHdrSchema(
      guid: json['guid'],
      recipeText: json['recipe_text'] ?? 'N/A',
      recipeStars: json['recipe_stars'] ?? 0,
      recipeReview: json['recipe_reiview'] ?? 'N/A',
      createdById: json['created_by_user_guid'],
      updatedById: json['updated_by_user_guid'],
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
      expiryDate: DateTime.parse(json['updated_date']),

    );
  }


  String formatDate(DateTime date){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    String formattedDate = dateFormat.format(date);
    String microseconds = date.microsecond.toString().padLeft(6, '0');
    String formattedDateTime = '$formattedDate.$microseconds' + 'Z';
    return formattedDateTime;
  }
}
