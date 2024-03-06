import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage({
  required BuildContext context,
  required Function(File) setImage,
}) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    final imageFile = File(pickedImage.path);
    setImage(imageFile);
  }
}
