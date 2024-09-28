class RecipeDto {
  final String recipeText;
  final String userId;
  
  RecipeDto({
    required this.recipeText,
    required this.userId,
  });


  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      'recipeText': recipeText,
      'userId': userId,
    };
  }
}
