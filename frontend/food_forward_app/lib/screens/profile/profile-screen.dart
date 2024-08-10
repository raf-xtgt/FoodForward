import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_forward_app/api/api-services/api-model/db-model/FileStorageRef.dart';
import 'package:food_forward_app/api/api-services/api-model/db-schema/file-storage-ref.dart';
import 'package:food_forward_app/api/api-services/shared-utils/api-service.dart';
import 'package:food_forward_app/utils/config.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: 'accessToken');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Profile Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Some information about the user goes here.'),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        onPressed: () => _logout(context),
                        child: const Text('Log Out'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Add spacing between card and other content
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
                const String url = "${Config.baseApiUrl}/upload-image/create";
                 await ApiService.postMethod(cont.toJson(), url);
                // Show a dialog with the result
              },
              child: const Text('Send Data'),
            ),
          ],
        ),
      ),
    );
  }
}
