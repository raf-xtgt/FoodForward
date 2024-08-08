import 'package:flutter/foundation.dart';

class DocumentCaptureState extends ChangeNotifier {
  final List<String> _images = [];
  int _imagesTaken = 0;

  List<String> get images => List.unmodifiable(_images);
  int get imagesTaken => _imagesTaken;

  void addImage(String imagePath) {
    _images.add(imagePath);
    notifyListeners();
  }

  void incrementImagesTaken() {
    _imagesTaken++;
    notifyListeners();
  }
}
