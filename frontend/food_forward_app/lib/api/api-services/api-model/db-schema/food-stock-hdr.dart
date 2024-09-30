import 'package:intl/intl.dart';

class FoodStockHdrSchema {
  final String guid;
  final String name;
  final String quantity;
  final String unitPrice;
  final String txnAmt;
  final String createdById;
  final String updatedById;
  final DateTime createdDate;
  final DateTime updatedDate;
  final DateTime expiryDate;


  FoodStockHdrSchema({
    required this.guid,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.txnAmt,
    required this.createdById,
    required this.updatedById,
    required this.createdDate,
    required this.updatedDate,
    required this.expiryDate,
  });

  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      "food_stock_hdr" :{
        'guid': guid,
        'name': name,
        'quantity': quantity,
        'unit_price': unitPrice,
        'txn_amt': txnAmt,
        'created_by_id': createdById,
        'updated_by_id': updatedById,
        'created_date':  formatDate(createdDate),
        'updated_date': formatDate(updatedDate),
        'expiry_date': formatDate(expiryDate),
      }
    };
  }

   // Create a factory constructor to create FoodItem from JSON
  factory FoodStockHdrSchema.fromJson(Map<String, dynamic> json) {
    return FoodStockHdrSchema(
      guid: json['guid'],
      name: json['name'] ?? 'Unknown',
      quantity: json['quantity'] ?? 'N/A',
      unitPrice: json['unit_price'] ?? 'N/A',
      txnAmt: json['txn_amt'] ?? 'N/A',
      createdById: json['created_by_id'],
      updatedById: json['updated_by_id'],
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
      expiryDate: json['expiry_date'] != null ? DateTime.parse(json['expiry_date']) : DateTime.now().add(Duration(days: 14)),

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
