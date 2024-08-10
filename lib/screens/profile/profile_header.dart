import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';

class ProfileHeader extends StatelessWidget {
  final bool isEditing;

  const ProfileHeader({
    super.key,
    required this.isEditing,
  });

  Future<void> _changeProfileImage(BuildContext context, UserProfileProvider userProfileProvider) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      userProfileProvider.setProfileImagePath(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Row(
      children: [
        GestureDetector(
          onTap: isEditing ? () => _changeProfileImage(context, userProfileProvider) : null,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: userProfileProvider.profileImagePath.isNotEmpty
                ? FileImage(File(userProfileProvider.profileImagePath))
                : const AssetImage('assets/images/profile_picture.png') as ImageProvider,
            child: userProfileProvider.profileImagePath.isEmpty
                ? const Icon(Icons.camera_alt, size: 50)
                : null,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: isEditing
              ? TextField(
                  decoration: const InputDecoration(labelText: 'ユーザー名'),
                  controller: TextEditingController(text: userProfileProvider.userName),
                  onChanged: (value) => userProfileProvider.setUserName(value),
                )
              : Text(
                  userProfileProvider.userName,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
        ),
      ],
    );
  }
}