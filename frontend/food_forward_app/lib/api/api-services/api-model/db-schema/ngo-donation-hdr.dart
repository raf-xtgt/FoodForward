import 'package:intl/intl.dart';

class NgoDonationHdrSchema {
  final String guid;
  final String docNo;
  final String ngoGuid;
  final String ngoName;
  final String ngoCode;
  final String donorId;
  final String description;
  final DateTime createdDate;
  final DateTime updatedDate;

  NgoDonationHdrSchema({
    required this.guid,
    required this.docNo,
    required this.ngoGuid,
    required this.ngoName,
    required this.ngoCode,
    required this.donorId,
    required this.description,
    required this.createdDate,
    required this.updatedDate,
  });

  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      "ngo_donation_hdr" :{
        'guid': guid,
        'doc_no': docNo,
        'ngo_guid': docNo,
        'ngo_name': docNo,
        'ngo_code': docNo,
        'donor_id': docNo,
        'description': description,
        'created_date':  formatDate(createdDate),
        'updated_date': formatDate(updatedDate),
      }
    };
  }

   // Create a factory constructor to create FoodItem from JSON
  factory NgoDonationHdrSchema.fromJson(Map<String, dynamic> json) {
    return NgoDonationHdrSchema(
      guid: json['guid'],
      docNo: json['doc_no'] ?? 'N/A',
      ngoGuid: json['ngo_guid'],
      ngoName: json['ngo_name'] ?? 'N/A',
      ngoCode: json['ngo_code'] ?? 'N/A',
      donorId: json['donor_id'] ?? 'N/A',
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
