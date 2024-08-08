import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String? imagePath;
  final ValueChanged<String> onImagePicked;

  const ProfilePictureWidget({
    super.key,
    this.imagePath,
    required this.onImagePicked,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _pickImage(context),
        child: CircleAvatar(
          radius: 50,
          backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
          child: imagePath == null ? const Icon(Icons.camera_alt, size: 50) : null,
        ),
      ),
    );
  }
}