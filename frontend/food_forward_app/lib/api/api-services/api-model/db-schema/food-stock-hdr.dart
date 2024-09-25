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
  });

  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'name': name,
      'quantity': quantity,
      'unit_price': unitPrice,
      'txn_amt': txnAmt,
      'created_by_id': createdById,
      'updated_by_id': updatedById,
      'created_date':  formatDate(createdDate),
      'updated_date': formatDate(updatedDate),
    };
  }

  String formatDate(DateTime date){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    String formattedDate = dateFormat.format(date);
    String microseconds = date.microsecond.toString().padLeft(6, '0');
    String formattedDateTime = '$formattedDate.$microseconds' + 'Z';
    return formattedDateTime;
  }
}
