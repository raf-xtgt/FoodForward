import 'package:intl/intl.dart';

class FileStorageRefSchema {
  final String guid;
  final String fileName;
  final String fileUrl;
  final String descr;
  final String createdByUserGuid;
  final String updatedByUserGuid;
  final DateTime createdDate;
  final DateTime updatedDate;

  FileStorageRefSchema({
    required this.guid,
    required this.fileName,
    required this.fileUrl,
    required this.descr,
    required this.createdByUserGuid,
    required this.updatedByUserGuid,
    required this.createdDate,
    required this.updatedDate,
  });

  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'file_name': fileName,
      'file_url': fileUrl,
      'descr': descr,
      'created_by_user_guid': createdByUserGuid,
      'updated_by_user_guid': updatedByUserGuid,
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
