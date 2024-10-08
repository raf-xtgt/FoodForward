import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_forward_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:http_parser/http_parser.dart'; // Needed for MediaType

class ImageUploadService {
  
  static Future<void> uploadImages(final List<String> _images, ) async {
      final FlutterSecureStorage storage = FlutterSecureStorage();
      final String? userId = await storage.read(key: 'userId');
      final String url = "${Config.baseApiUrl}/upload-image/multi/$userId";
      print("Upload url: " + url);
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      
      for (String imagePath in _images) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'files', // This should match the @RequestParam name in your endpoint
            imagePath,
            contentType: MediaType('image', 'jpeg'), // Adjust the media type as needed
          ),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Upload successful');

      } else {
        print('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }
  
}
