import 'package:food_forward_app/api/api-services/api-model/db-schema/file-storage-ref.dart';


class FilestorageRef {
  final FileStorageRefSchema fileStorageRefSchema;

  FilestorageRef({
    required this.fileStorageRefSchema
  });

  // Convert a FileStorageRef object to a map
  Map<String, dynamic> toJson() {
    return {
      'file_storage_ref': fileStorageRefSchema.toJson(),
    };
  }
}
