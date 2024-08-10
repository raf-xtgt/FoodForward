import 'package:flutter/material.dart';
import 'package:food_forward_app/api/api-services/api-model/db-model/FileStorageRef.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/file-storage-ref.dart';
import 'package:food_forward_app/api/api-services/shared-utils/api-service.dart';
import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Profile Page Content'),
        const SizedBox(height: 20), // Add spacing between text and button
        ElevatedButton(
          onPressed: () async {
            // Create an instance of FileStorageRef
            FileStorageRefSchema fileStorageRefSchema = FileStorageRefSchema(
              guid: '123e4567-e89b-12d3-a456-426614174000', // Example UUID
              fileName: 'testexample.txt',
              fileUrl: 'https://example.com/files/example.txt',
              descr: 'Example file description',
              createdByUserGuid: 'user-uuid-123',
              updatedByUserGuid: 'user-uuid-123',
              createdDate: DateTime.now(),
              updatedDate: DateTime.now(),
            );
            
            final FilestorageRef cont = FilestorageRef(fileStorageRefSchema: fileStorageRefSchema);

            // Call the postData method and handle the result
            const String url =  "${Config.baseApiUrl}/upload-image/create";
            http.Response result = await ApiService.postMethod(cont.toJson(), url);
            // Show a dialog with the result
          },
          child: const Text('Send Data'),
        ),
      ],
    );
  }
}