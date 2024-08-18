import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'icon_change_logic.dart';
import '../../providers/user_profile_provider.dart';

class ProfileHeader extends ConsumerWidget {
  final bool isEditing;

  const ProfileHeader({
    super.key,
    required this.isEditing,
    required this.onImageSelected,
  });

  final void Function(String imagePath) onImageSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);

    return GestureDetector(
      onTap: isEditing ? () => _showIconChangeOptions(context) : null,
      child: Stack(
        children: [
          _buildProfileImage(userProfile.profileImagePath),
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _showIconChangeOptions(context),
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

  void _showIconChangeOptions(BuildContext context) {
    IconChangeLogic(context).showIconChangeOptions();
  }

  Widget _buildProfileImage(String imagePath) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: imagePath.isNotEmpty
          ? FileImage(File(imagePath)) as ImageProvider
          : const AssetImage('assets/images/null_icon.png'),
      backgroundColor: Colors.grey[200],
    );
  }
}