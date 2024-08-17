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
      onTap: isEditing ? () => _showImageOptions(context, provider) : null,
      child: Stack(
        children: [
          _buildProfileImage(provider),
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _showImageOptions(context, provider),
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

  void _showImageOptions(BuildContext context, UserProfileProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('ライブラリから選択'),
                onTap: () {
                  _pickImage(context, provider, ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('カメラで撮影'),
                onTap: () {
                  _pickImage(context, provider, ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              if (provider.profileImagePath.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('画像を削除'),
                  onTap: () {
                    provider.removeProfileImage(); // 画像を削除
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context, UserProfileProvider provider, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

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
          : const AssetImage('assets/default_profile.png'), // デフォルト画像
      backgroundColor: Colors.grey[200],
    );
  }
}