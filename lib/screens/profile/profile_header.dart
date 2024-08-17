import 'package:fa1/providers/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatelessWidget {
  final bool isEditing;

  const ProfileHeader({
    super.key,
    required this.isEditing,
    required this.onImageSelected,
  });

  final void Function(String imagePath) onImageSelected;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProfileProvider>(context);

    return GestureDetector(
      onTap: isEditing ? () => _pickImage(context, provider) : null,
      child: Stack(
        children: [
          _buildProfileImage(provider),
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _pickImage(context, provider),
                child: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 15,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, UserProfileProvider provider) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      provider.setProfileImagePath(pickedFile.path);
      onImageSelected(pickedFile.path); // 選択された画像のパスをコールバックで渡す
    }
  }

  Widget _buildProfileImage(UserProfileProvider provider) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: provider.profileImagePath.isNotEmpty
          ? FileImage(File(provider.profileImagePath))
          : const AssetImage('assets/default_profile.png'),
      backgroundColor: Colors.grey[200],
    );
  }
}