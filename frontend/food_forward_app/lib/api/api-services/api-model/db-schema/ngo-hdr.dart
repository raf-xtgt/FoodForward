import 'package:intl/intl.dart';

class NgoHdrSchema {
  final String guid;
  final String name;
  final String code;
  final String description;
  final DateTime createdDate;
  final DateTime updatedDate;

  NgoHdrSchema({
    required this.guid,
    required this.name,
    required this.code,
    required this.description,
    required this.createdDate,
    required this.updatedDate,
  });

  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      "food_stock_hdr" :{
        'guid': guid,
        'name': name,
        'code': code,
        'description': description,
        'created_date':  formatDate(createdDate),
        'updated_date': formatDate(updatedDate),
      }
    };
  }

   // Create a factory constructor to create FoodItem from JSON
  factory NgoHdrSchema.fromJson(Map<String, dynamic> json) {
    return NgoHdrSchema(
      guid: json['guid'],
      name: json['name'] ?? 'Unknown',
      code: json['code'] ?? 'N/A',
      description: json['description'] ?? 'N/A',
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
      
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
